module 0x1b9c05b54908b4aeb5ba24454e506d128ff0f91820fe0eb772810057f5e4bc32::kiosk_gift_transfer {
    struct PersonalKioskMarker has copy, drop, store {
        dummy_field: bool,
    }

    struct KioskGift has store, key {
        id: 0x2::object::UID,
        kiosk_id: 0x2::object::ID,
        cap: 0x2::kiosk::KioskOwnerCap,
        recipient: address,
        sender: address,
        claimed: bool,
    }

    struct KioskGiftCreated has copy, drop {
        gift_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        sender: address,
        recipient: address,
    }

    struct KioskGiftClaimed has copy, drop {
        gift_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        sender: address,
        recipient: address,
    }

    struct KIOSK_GIFT_TRANSFER has drop {
        dummy_field: bool,
    }

    public entry fun claim_kiosk_gift(arg0: &mut KioskGift, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.recipient == 0x2::tx_context::sender(arg1), 3);
        assert!(!arg0.claimed, 4);
        arg0.claimed = true;
        let v0 = KioskGiftClaimed{
            gift_id   : 0x2::object::id<KioskGift>(arg0),
            kiosk_id  : arg0.kiosk_id,
            sender    : arg0.sender,
            recipient : arg0.recipient,
        };
        0x2::event::emit<KioskGiftClaimed>(v0);
    }

    public entry fun create_kiosk_gift(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::kiosk::KioskOwnerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg3), 1);
        assert!(0x2::kiosk::has_access(arg0, &arg1), 2);
        let v0 = KioskGift{
            id        : 0x2::object::new(arg3),
            kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            cap       : arg1,
            recipient : arg2,
            sender    : 0x2::tx_context::sender(arg3),
            claimed   : false,
        };
        let v1 = KioskGiftCreated{
            gift_id   : 0x2::object::id<KioskGift>(&v0),
            kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            sender    : 0x2::tx_context::sender(arg3),
            recipient : arg2,
        };
        0x2::event::emit<KioskGiftCreated>(v1);
        0x2::transfer::public_transfer<KioskGift>(v0, arg2);
    }

    public entry fun extract_kiosk_cap(arg0: KioskGift, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.recipient == 0x2::tx_context::sender(arg1), 3);
        let KioskGift {
            id        : v0,
            kiosk_id  : _,
            cap       : v2,
            recipient : _,
            sender    : _,
            claimed   : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun get_gift_recipient(arg0: &KioskGift) : address {
        arg0.recipient
    }

    public fun get_gift_sender(arg0: &KioskGift) : address {
        arg0.sender
    }

    public fun get_kiosk_id(arg0: &KioskGift) : 0x2::object::ID {
        arg0.kiosk_id
    }

    public fun is_gift_claimed(arg0: &KioskGift) : bool {
        arg0.claimed
    }

    public fun is_personal_kiosk(arg0: &0x2::kiosk::Kiosk) : bool {
        let v0 = PersonalKioskMarker{dummy_field: false};
        0x2::dynamic_field::exists_<PersonalKioskMarker>(0x2::kiosk::uid(arg0), v0)
    }

    public entry fun transfer_kiosk_with_contents(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::kiosk::KioskOwnerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        create_kiosk_gift(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

