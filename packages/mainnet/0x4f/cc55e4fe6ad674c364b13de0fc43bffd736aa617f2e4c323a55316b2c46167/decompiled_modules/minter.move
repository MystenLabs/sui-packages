module 0x4fcc55e4fe6ad674c364b13de0fc43bffd736aa617f2e4c323a55316b2c46167::minter {
    struct App has key {
        id: 0x2::object::UID,
        version: u64,
        operator_pk: vector<u8>,
        start_time: u64,
        end_time: u64,
        minted: u64,
        max_nft: u64,
        fee_receiver: address,
        mint_fee: u64,
    }

    struct UpdateConfig has copy, drop, store {
        operator_pk: vector<u8>,
        fee_receiver: address,
        start_time: u64,
        end_time: u64,
        mint_fee: u64,
        max_nft: u64,
    }

    struct NftMinted has copy, drop, store {
        receiver: address,
        mint_fee: u64,
        nft_id: 0x2::object::ID,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    entry fun authorize_nft(arg0: &0x4fcc55e4fe6ad674c364b13de0fc43bffd736aa617f2e4c323a55316b2c46167::wave_recap::OwnerCap, arg1: &mut App) {
        assert!(arg1.version <= 1, 1);
        0x4fcc55e4fe6ad674c364b13de0fc43bffd736aa617f2e4c323a55316b2c46167::wave_recap::authorize_app(arg0, &mut arg1.id, 0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0xfdefe17a05a90060ef50ef578992df05f55ee11d31877d0c3010cbe36781f1b0;
        let v1 = App{
            id           : 0x2::object::new(arg0),
            version      : 1,
            operator_pk  : 0x2::bcs::to_bytes<address>(&v0),
            start_time   : 0,
            end_time     : 0,
            minted       : 0,
            max_nft      : 0,
            fee_receiver : @0xcdf91c9cffe55ad1954a1eb7ed0eec17cad2549f8dec18b9221b4ebd618986d8,
            mint_fee     : 1000000000,
        };
        0x2::transfer::share_object<App>(v1);
        let v2 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun is_minted(arg0: &App, arg1: address) : bool {
        0x2::dynamic_field::exists_<address>(&arg0.id, arg1)
    }

    entry fun migrate(arg0: &OwnerCap, arg1: &mut App) {
        assert!(arg1.version < 1, 9);
        arg1.version = 1;
    }

    entry fun mint(arg0: &mut App, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 1);
        let v0 = 0x2::tx_context::sender(arg8);
        validate_signature(arg0.operator_pk, v0, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        assert!(arg0.start_time == 0 || v1 >= arg0.start_time, 2);
        assert!(arg0.end_time == 0 || v1 <= arg0.end_time, 3);
        assert!(!is_minted(arg0, v0), 6);
        0x2::dynamic_field::add<address, bool>(&mut arg0.id, v0, true);
        assert!(arg0.max_nft == 0 || arg0.minted < arg0.max_nft, 4);
        arg0.minted = arg0.minted + 1;
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v2 >= arg0.mint_fee, 5);
        let v3 = if (v2 > arg0.mint_fee) {
            0x2::pay::keep<0x2::sui::SUI>(arg1, arg8);
            0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg0.mint_fee, arg8)
        } else {
            arg1
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, arg0.fee_receiver);
        let v4 = NftMinted{
            receiver : v0,
            mint_fee : arg0.mint_fee,
            nft_id   : 0x4fcc55e4fe6ad674c364b13de0fc43bffd736aa617f2e4c323a55316b2c46167::wave_recap::mint(&mut arg0.id, v0, arg2, arg3, arg4, arg8),
        };
        0x2::event::emit<NftMinted>(v4);
    }

    public entry fun update_config(arg0: &OwnerCap, arg1: &mut App, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: u64) {
        assert!(arg1.version <= 1, 1);
        arg1.operator_pk = arg2;
        arg1.start_time = arg3;
        arg1.fee_receiver = arg5;
        arg1.end_time = arg4;
        arg1.mint_fee = arg6;
        arg1.max_nft = arg7;
        let v0 = UpdateConfig{
            operator_pk  : arg2,
            fee_receiver : arg5,
            start_time   : arg3,
            end_time     : arg4,
            mint_fee     : arg6,
            max_nft      : arg7,
        };
        0x2::event::emit<UpdateConfig>(v0);
    }

    fun validate_signature(arg0: vector<u8>, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock) {
        let v0 = 0x1::string::utf8(b"WAVE_RECAP_MINT_NFT:");
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
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg5));
        assert!(0x2::ed25519::ed25519_verify(&arg6, &arg0, &v1) == true, 7);
        assert!(0x2::clock::timestamp_ms(arg7) < arg5, 8);
    }

    // decompiled from Move bytecode v6
}

