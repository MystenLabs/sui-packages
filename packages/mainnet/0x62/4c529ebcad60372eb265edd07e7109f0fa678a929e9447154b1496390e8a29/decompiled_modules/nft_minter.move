module 0x624c529ebcad60372eb265edd07e7109f0fa678a929e9447154b1496390e8a29::nft_minter {
    struct App has key {
        id: 0x2::object::UID,
        operator_pk: vector<u8>,
        version: u8,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct NftMinted has copy, drop, store {
        receiver: address,
        nft_id: 0x2::object::ID,
    }

    entry fun authorize_nft(arg0: &0x624c529ebcad60372eb265edd07e7109f0fa678a929e9447154b1496390e8a29::wave_pad_nft::NftOwnerCap, arg1: &mut App) {
        0x624c529ebcad60372eb265edd07e7109f0fa678a929e9447154b1496390e8a29::wave_pad_nft::authorize_app(arg0, &mut arg1.id, 0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0x602160773de916dbf5cb7dd2283bdfb03fed0433628b5fb1cd41f9e86a924067;
        let v1 = App{
            id          : 0x2::object::new(arg0),
            operator_pk : 0x2::bcs::to_bytes<address>(&v0),
            version     : 1,
        };
        0x2::transfer::share_object<App>(v1);
        let v2 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v2, 0x2::tx_context::sender(arg0));
    }

    entry fun mint_nft(arg0: &mut App, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u16, arg5: vector<u8>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 1);
        let v0 = 0x2::tx_context::sender(arg8);
        validate_signature(arg0, v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        assert!(!0x2::dynamic_field::exists_<address>(&arg0.id, v0), 4);
        0x2::dynamic_field::add<address, bool>(&mut arg0.id, v0, true);
        let v1 = 0x624c529ebcad60372eb265edd07e7109f0fa678a929e9447154b1496390e8a29::wave_pad_nft::mint(&mut arg0.id, arg1, arg2, arg3, arg4, arg8);
        0x2::transfer::public_transfer<0x624c529ebcad60372eb265edd07e7109f0fa678a929e9447154b1496390e8a29::wave_pad_nft::NFT>(v1, v0);
        let v2 = NftMinted{
            receiver : v0,
            nft_id   : 0x624c529ebcad60372eb265edd07e7109f0fa678a929e9447154b1496390e8a29::wave_pad_nft::get_id(&v1),
        };
        0x2::event::emit<NftMinted>(v2);
    }

    fun validate_signature(arg0: &App, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u16, arg6: vector<u8>, arg7: u64, arg8: &0x2::clock::Clock) {
        let v0 = 0x1::string::utf8(b"WAVE_PAD_MINT_NFT:");
        let v1 = 0x2::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg1));
        let v2 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<vector<u8>>(&arg2));
        let v3 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v3));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<vector<u8>>(&arg3));
        let v4 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v4));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<vector<u8>>(&arg4));
        let v5 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v5));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u16>(&arg5));
        let v6 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v6));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg7));
        assert!(0x2::ed25519::ed25519_verify(&arg6, &arg0.operator_pk, &v1) == true, 2);
        assert!(0x2::clock::timestamp_ms(arg8) < arg7, 3);
    }

    // decompiled from Move bytecode v6
}

