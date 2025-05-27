module 0xd9c729a1eb2ae92d4bd8475cafe23f6d608cc1c45e5aa6ff9b7db187311f1b16::tradeport {
    struct TRADEPORT has drop {
        dummy_field: bool,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
        rarity: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct RoyaltyCollected has copy, drop {
        amount: u64,
        recipient: address,
        nft_id: 0x2::object::ID,
    }

    public fun confirm_transfer(arg0: &mut 0x2::transfer_policy::TransferPolicy<Nft>, arg1: 0x2::transfer_policy::TransferRequest<Nft>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::kiosk::Kiosk, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd9c729a1eb2ae92d4bd8475cafe23f6d608cc1c45e5aa6ff9b7db187311f1b16::royalty_rule::fee_amount<Nft>(arg0, 0x2::coin::value<0x2::sui::SUI>(&arg2));
        assert!(v0 > 0, 4);
        0xd9c729a1eb2ae92d4bd8475cafe23f6d608cc1c45e5aa6ff9b7db187311f1b16::royalty_rule::pay<Nft>(arg0, &mut arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg4));
        0xd9c729a1eb2ae92d4bd8475cafe23f6d608cc1c45e5aa6ff9b7db187311f1b16::kiosk_lock_rule::prove<Nft>(&mut arg1, arg3);
        0xd9c729a1eb2ae92d4bd8475cafe23f6d608cc1c45e5aa6ff9b7db187311f1b16::witness_rule::prove<Nft, TRADEPORT>(arg0, &mut arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v1);
        let v2 = RoyaltyCollected{
            amount    : v0,
            recipient : v1,
            nft_id    : 0x2::transfer_policy::item<Nft>(&arg1),
        };
        0x2::event::emit<RoyaltyCollected>(v2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<Nft>(arg0, arg1);
    }

    fun create_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) : Nft {
        Nft{
            id          : 0x2::object::new(arg6),
            name        : arg0,
            description : arg1,
            image_url   : arg2,
            creator     : 0x2::tx_context::sender(arg6),
            rarity      : arg3,
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg4, arg5),
        }
    }

    fun init(arg0: TRADEPORT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TRADEPORT>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Tradeport NFT"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(b"A unique NFT on the Sui blockchain"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_image_url"), 0x1::string::utf8(b"ipfs://example-nft-url"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<Nft>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v1, 0x2::tx_context::sender(arg1));
        let (v2, v3) = 0x2::transfer_policy::new<Nft>(&v0, arg1);
        let v4 = v3;
        let v5 = v2;
        0xd9c729a1eb2ae92d4bd8475cafe23f6d608cc1c45e5aa6ff9b7db187311f1b16::kiosk_lock_rule::add<Nft>(&mut v5, &v4);
        0xd9c729a1eb2ae92d4bd8475cafe23f6d608cc1c45e5aa6ff9b7db187311f1b16::royalty_rule::add<Nft>(&mut v5, &v4, (500 as u16), 0);
        0xd9c729a1eb2ae92d4bd8475cafe23f6d608cc1c45e5aa6ff9b7db187311f1b16::witness_rule::add<Nft, TRADEPORT>(&mut v5, &v4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft>>(v5);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Nft>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun list_nft(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64) {
        0x2::kiosk::list<Nft>(arg0, arg1, arg2, arg3);
    }

    public fun mint_nft(arg0: &0x2::transfer_policy::TransferPolicy<Nft>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = create_nft(arg1, arg2, arg3, arg4, arg5, arg6, arg8);
        let (v1, v2) = 0x2::kiosk::new(arg8);
        let v3 = v2;
        let v4 = v1;
        0x2::kiosk::lock<Nft>(&mut v4, &v3, arg0, v0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, arg7);
    }

    public fun mint_nft_with_payment(arg0: &0x2::transfer_policy::TransferPolicy<Nft>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: u64, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg8) >= arg7, 4);
        let v0 = create_nft(arg1, arg2, arg3, arg4, arg5, arg6, arg10);
        let (v1, v2) = 0x2::kiosk::new(arg10);
        let v3 = v2;
        let v4 = v1;
        0x2::kiosk::lock<Nft>(&mut v4, &v3, arg0, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg8, 0x2::tx_context::sender(arg10));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, arg9);
    }

    public fun update_nft(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::borrow_mut<Nft>(arg0, arg1, arg2);
        assert!(v0.creator == 0x2::tx_context::sender(arg8), 3);
        v0.name = arg3;
        v0.description = arg4;
        v0.image_url = arg5;
        v0.attributes = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg6, arg7);
    }

    public fun withdraw_royalty(arg0: &mut 0x2::transfer_policy::TransferPolicy<Nft>, arg1: &0x2::transfer_policy::TransferPolicyCap<Nft>, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer_policy::withdraw<Nft>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

