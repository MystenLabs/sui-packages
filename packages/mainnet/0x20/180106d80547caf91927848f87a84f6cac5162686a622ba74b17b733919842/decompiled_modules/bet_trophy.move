module 0x20180106d80547caf91927848f87a84f6cac5162686a622ba74b17b733919842::bet_trophy {
    struct BET_TROPHY has drop {
        dummy_field: bool,
    }

    struct MintAuthority has key {
        id: 0x2::object::UID,
        admin: address,
        oracle_pubkey: vector<u8>,
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
        let v6 = 0x2::tx_context::sender(arg1);
        let v7 = MintAuthority{
            id            : 0x2::object::new(arg1),
            admin         : v6,
            oracle_pubkey : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<MintAuthority>(v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<BetTrophy>>(v5, v6);
    }

    public entry fun mint(arg0: &MintAuthority, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg1) > 0, 0);
        assert!(0x1::string::length(&arg2) > 0, 12);
        assert!(0x1::string::length(&arg3) > 0, 13);
        assert!(0x1::string::length(&arg4) > 0, 14);
        assert!(0x1::string::length(&arg5) > 0, 15);
        assert!(0x1::string::length(&arg6) > 0, 1);
        assert!(0x1::string::length(&arg7) > 0, 2);
        assert!(0x1::string::length(&arg8) > 0, 16);
        assert!(0x1::string::length(&arg1) <= 256, 3);
        assert!(0x1::string::length(&arg2) <= 256, 4);
        assert!(0x1::string::length(&arg3) <= 32, 5);
        assert!(0x1::string::length(&arg4) <= 64, 6);
        assert!(0x1::string::length(&arg5) <= 32, 7);
        assert!(0x1::string::length(&arg6) <= 256, 8);
        assert!(0x1::string::length(&arg7) <= 1024, 9);
        assert!(0x1::string::length(&arg8) <= 1024, 10);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = arg0.oracle_pubkey;
        assert!(0x1::vector::length<u8>(&v1) == 32, 11);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<address>(&v0));
        0x1::vector::append<u8>(&mut v2, *0x1::string::bytes(&arg6));
        0x1::vector::append<u8>(&mut v2, *0x1::string::bytes(&arg4));
        0x1::vector::append<u8>(&mut v2, *0x1::string::bytes(&arg5));
        assert!(0x2::ed25519::ed25519_verify(&arg9, &v1, &v2), 11);
        let v3 = BetTrophy{
            id           : 0x2::object::new(arg10),
            name         : arg1,
            description  : build_description(&arg2, &arg3, &arg4, &arg5, &arg6),
            prediction   : arg2,
            odds         : arg3,
            payout       : arg4,
            currency     : arg5,
            blob_id      : arg6,
            image_url    : arg7,
            metadata_url : arg8,
            minted_by    : v0,
            minted_epoch : 0x2::tx_context::epoch(arg10),
        };
        let v4 = TrophyMinted{
            trophy_id : 0x2::object::uid_to_address(&v3.id),
            minted_by : v0,
            name      : v3.name,
            blob_id   : v3.blob_id,
            payout    : v3.payout,
            currency  : v3.currency,
        };
        0x2::event::emit<TrophyMinted>(v4);
        0x2::transfer::public_transfer<BetTrophy>(v3, v0);
    }

    public entry fun set_oracle_pubkey(arg0: &mut MintAuthority, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 17);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 11);
        arg0.oracle_pubkey = arg1;
    }

    // decompiled from Move bytecode v6
}

