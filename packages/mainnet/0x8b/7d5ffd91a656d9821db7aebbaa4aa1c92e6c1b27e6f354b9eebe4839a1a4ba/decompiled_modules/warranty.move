module 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty {
    struct WarrantyClaimTicket has store, key {
        id: 0x2::object::UID,
        warranty: Warranty,
        evidence: 0x1::string::String,
    }

    struct ActivatedPotato {
        dummy_field: bool,
    }

    struct Warranty has store, key {
        id: 0x2::object::UID,
        escrow_id: 0x2::object::ID,
        beneficiary: address,
        coin_type_name: 0x1::string::String,
        cover_coin_amount: u64,
        price: u64,
        guarantee_until: u64,
        activated: bool,
    }

    struct WarrantyActivated has copy, drop {
        warranty_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
        beneficiary: address,
        coin_type_name: 0x1::string::String,
        cover_coin_amount: u64,
        price: u64,
        guarantee_until: u64,
    }

    struct WarrantyClaimTicketCreated has copy, drop {
        ticket_id: 0x2::object::ID,
        warranty_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
        beneficiary: address,
        coin_type_name: 0x1::string::String,
        cover_coin_amount: u64,
        price: u64,
        guarantee_until: u64,
        evidence: 0x1::string::String,
    }

    struct WarrantedCoinClaimed has copy, drop {
        ticket_id: 0x2::object::ID,
        warranty_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
        beneficiary: address,
        coin_type_name: 0x1::string::String,
        cover_coin_amount: u64,
        price: u64,
        guarantee_until: u64,
        evidence: 0x1::string::String,
    }

    struct WarrantyClaimTicketCanceled has copy, drop {
        ticket_id: 0x2::object::ID,
        warranty_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
        beneficiary: address,
        coin_type_name: 0x1::string::String,
        cover_coin_amount: u64,
        price: u64,
        guarantee_until: u64,
    }

    public(friend) fun delete(arg0: Warranty) {
        let Warranty {
            id                : v0,
            escrow_id         : _,
            beneficiary       : _,
            coin_type_name    : _,
            cover_coin_amount : _,
            price             : _,
            guarantee_until   : _,
            activated         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun activate_warranty(arg0: &mut Warranty, arg1: &0x2::clock::Clock) : ActivatedPotato {
        arg0.activated = true;
        arg0.guarantee_until = 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::math::safe_add_u64(0x2::clock::timestamp_ms(arg1), 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::math::safe_mul_u64(2592000000, arg0.guarantee_until));
        let v0 = WarrantyActivated{
            warranty_id       : 0x2::object::id<Warranty>(arg0),
            escrow_id         : arg0.escrow_id,
            beneficiary       : arg0.beneficiary,
            coin_type_name    : arg0.coin_type_name,
            cover_coin_amount : arg0.cover_coin_amount,
            price             : arg0.price,
            guarantee_until   : arg0.guarantee_until,
        };
        0x2::event::emit<WarrantyActivated>(v0);
        ActivatedPotato{dummy_field: false}
    }

    public fun cancel_ticket(arg0: WarrantyClaimTicket, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.warranty.beneficiary, 205);
        let WarrantyClaimTicket {
            id       : v0,
            warranty : v1,
            evidence : _,
        } = arg0;
        let v3 = v1;
        let v4 = v0;
        0x2::object::delete(v4);
        let v5 = v3.beneficiary;
        0x2::transfer::public_transfer<Warranty>(v3, v5);
        let v6 = WarrantyClaimTicketCanceled{
            ticket_id         : 0x2::object::uid_to_inner(&v4),
            warranty_id       : 0x2::object::id<Warranty>(&v3),
            escrow_id         : v3.escrow_id,
            beneficiary       : v5,
            coin_type_name    : v3.coin_type_name,
            cover_coin_amount : v3.cover_coin_amount,
            price             : v3.price,
            guarantee_until   : v3.guarantee_until,
        };
        0x2::event::emit<WarrantyClaimTicketCanceled>(v6);
    }

    public fun create_claim_ticket(arg0: Warranty, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.guarantee_until, 202);
        let v0 = WarrantyClaimTicket{
            id       : 0x2::object::new(arg3),
            warranty : arg0,
            evidence : arg1,
        };
        0x2::transfer::public_share_object<WarrantyClaimTicket>(v0);
        let v1 = WarrantyClaimTicketCreated{
            ticket_id         : 0x2::object::id<WarrantyClaimTicket>(&v0),
            warranty_id       : 0x2::object::id<Warranty>(&arg0),
            escrow_id         : arg0.escrow_id,
            beneficiary       : arg0.beneficiary,
            coin_type_name    : arg0.coin_type_name,
            cover_coin_amount : arg0.cover_coin_amount,
            price             : arg0.price,
            guarantee_until   : arg0.guarantee_until,
            evidence          : arg1,
        };
        0x2::event::emit<WarrantyClaimTicketCreated>(v1);
    }

    public(friend) fun new_warranty(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : Warranty {
        let v0 = 0x2::bcs::new(arg1);
        Warranty{
            id                : 0x2::object::new(arg2),
            escrow_id         : arg0,
            beneficiary       : 0x2::bcs::peel_address(&mut v0),
            coin_type_name    : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
            cover_coin_amount : 0x2::bcs::peel_u64(&mut v0),
            price             : 0x2::bcs::peel_u64(&mut v0),
            guarantee_until   : 0x2::bcs::peel_u64(&mut v0),
            activated         : false,
        }
    }

    public(friend) fun pay_for_ticket<T0>(arg0: WarrantyClaimTicket, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        assert!(arg0.warranty.coin_type_name == v0, 203);
        assert!(0x2::coin::value<T0>(arg1) >= arg0.warranty.cover_coin_amount, 204);
        0x2::pay::split_and_transfer<T0>(arg1, arg0.warranty.cover_coin_amount, arg0.warranty.beneficiary, arg2);
        let v1 = WarrantedCoinClaimed{
            ticket_id         : 0x2::object::id<WarrantyClaimTicket>(&arg0),
            warranty_id       : 0x2::object::id<Warranty>(&arg0.warranty),
            escrow_id         : arg0.warranty.escrow_id,
            beneficiary       : arg0.warranty.beneficiary,
            coin_type_name    : arg0.warranty.coin_type_name,
            cover_coin_amount : arg0.warranty.cover_coin_amount,
            price             : arg0.warranty.price,
            guarantee_until   : arg0.warranty.guarantee_until,
            evidence          : arg0.evidence,
        };
        0x2::event::emit<WarrantedCoinClaimed>(v1);
        let WarrantyClaimTicket {
            id       : v2,
            warranty : v3,
            evidence : _,
        } = arg0;
        0x2::object::delete(v2);
        let Warranty {
            id                : v5,
            escrow_id         : _,
            beneficiary       : _,
            coin_type_name    : _,
            cover_coin_amount : _,
            price             : _,
            guarantee_until   : _,
            activated         : _,
        } = v3;
        0x2::object::delete(v5);
    }

    public fun price(arg0: &Warranty) : u64 {
        arg0.price
    }

    public(friend) fun transfer_to_beneficiary(arg0: Warranty, arg1: ActivatedPotato) {
        0x2::transfer::public_transfer<Warranty>(arg0, arg0.beneficiary);
        let ActivatedPotato {  } = arg1;
    }

    // decompiled from Move bytecode v6
}

