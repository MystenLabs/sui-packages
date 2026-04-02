module 0xa5554b517e2fe19bf14710e65a905144f969aad6d764829d1a430e16828877ed::bet_trophy {
    struct BET_TROPHY has drop {
        dummy_field: bool,
    }

    struct BetTrophy has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        prediction: 0x1::string::String,
        odds: 0x1::string::String,
        payout: 0x1::string::String,
        currency: 0x1::string::String,
        blob_id: 0x1::string::String,
        image_url: 0x1::string::String,
        metadata_url: 0x1::string::String,
        minted_by: address,
        minted_epoch: u64,
    }

    struct TrophyMinted has copy, drop {
        trophy_id: address,
        minted_by: address,
        name: 0x1::string::String,
        blob_id: 0x1::string::String,
        payout: 0x1::string::String,
        currency: 0x1::string::String,
    }

    fun build_description(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: &0x1::string::String, arg4: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"Proof of Conviction: Won ");
        0x1::string::append(&mut v0, *arg2);
        0x1::string::append_utf8(&mut v0, b" ");
        0x1::string::append(&mut v0, *arg3);
        0x1::string::append_utf8(&mut v0, b" betting on \"");
        0x1::string::append(&mut v0, *arg0);
        0x1::string::append_utf8(&mut v0, b"\" at ");
        0x1::string::append(&mut v0, *arg1);
        0x1::string::append_utf8(&mut v0, b"x odds. Walrus blob: ");
        0x1::string::append(&mut v0, *arg4);
        0x1::string::append_utf8(&mut v0, b". Minted on Sui by SuiBets.");
        v0
    }

    fun init(arg0: BET_TROPHY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{metadata_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suibets.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SuiBets"));
        let v4 = 0x2::package::claim<BET_TROPHY>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<BetTrophy>(&v4, v0, v2, arg1);
        0x2::display::update_version<BetTrophy>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<BetTrophy>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg0) > 0, 0);
        assert!(0x1::string::length(&arg5) > 0, 1);
        assert!(0x1::string::length(&arg6) > 0, 2);
        assert!(0x1::string::length(&arg0) <= 256, 3);
        assert!(0x1::string::length(&arg1) <= 256, 4);
        assert!(0x1::string::length(&arg2) <= 32, 5);
        assert!(0x1::string::length(&arg3) <= 64, 6);
        assert!(0x1::string::length(&arg4) <= 32, 7);
        assert!(0x1::string::length(&arg5) <= 256, 8);
        assert!(0x1::string::length(&arg6) <= 1024, 9);
        assert!(0x1::string::length(&arg7) <= 1024, 10);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = BetTrophy{
            id           : 0x2::object::new(arg8),
            name         : arg0,
            description  : build_description(&arg1, &arg2, &arg3, &arg4, &arg5),
            prediction   : arg1,
            odds         : arg2,
            payout       : arg3,
            currency     : arg4,
            blob_id      : arg5,
            image_url    : arg6,
            metadata_url : arg7,
            minted_by    : v0,
            minted_epoch : 0x2::tx_context::epoch(arg8),
        };
        let v2 = TrophyMinted{
            trophy_id : 0x2::object::uid_to_address(&v1.id),
            minted_by : v0,
            name      : v1.name,
            blob_id   : v1.blob_id,
            payout    : v1.payout,
            currency  : v1.currency,
        };
        0x2::event::emit<TrophyMinted>(v2);
        0x2::transfer::public_transfer<BetTrophy>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

