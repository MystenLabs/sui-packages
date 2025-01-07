module 0xc7e213340f66a69d4d9e97e9e9f0b67b0ec49671358b3af0d7a84c0d5a5598f9::wave_claim {
    struct App has key {
        id: 0x2::object::UID,
        operator_pk: vector<u8>,
        version: u8,
    }

    struct TokenClaimed has copy, drop, store {
        receiver: address,
        coin_type: 0x1::string::String,
        id: u64,
        amount: u64,
    }

    struct NftClaimed has copy, drop, store {
        receiver: address,
        id: u64,
    }

    struct BoostClaimed has copy, drop, store {
        receiver: address,
        id: u64,
        level: u8,
    }

    struct GenesisNftClaimed has copy, drop, store {
        receiver: address,
        id: u64,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    entry fun admin_deposit<T0>(arg0: &OwnerCap, arg1: &mut App, arg2: 0x2::coin::Coin<T0>) {
        let v0 = type_to_bytes<T0>();
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v0)) {
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg1.id, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg1.id, v0), 0x2::coin::into_balance<T0>(arg2));
    }

    entry fun admin_withdraw<T0>(arg0: &OwnerCap, arg1: &mut App, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = type_to_bytes<T0>();
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v0)) {
            abort 4
        };
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg1.id, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun authorize_game(arg0: &0x1efaf509c9b7e986ee724596f526a22b474b15c376136772c00b8452f204d2d1::game::OwnerCap, arg1: &mut App) {
        0x1efaf509c9b7e986ee724596f526a22b474b15c376136772c00b8452f204d2d1::game::authorize_app(arg0, &mut arg1.id);
    }

    public fun authorize_genesis_nft(arg0: &0xb32dc6b71d2c13bb220957d0664b20b9b822c1deb48c930e6d112de9303f946a::wave_genesis_nft::NftOwnerCap, arg1: &mut App) {
        0xb32dc6b71d2c13bb220957d0664b20b9b822c1deb48c930e6d112de9303f946a::wave_genesis_nft::authorize_app(arg0, &mut arg1.id, 0);
    }

    public fun authorize_nft(arg0: &0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::NftOwnerCap, arg1: &mut App) {
        0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::authorize_app(arg0, &mut arg1.id, 0);
    }

    entry fun claim_boost(arg0: &mut App, arg1: &mut 0x1efaf509c9b7e986ee724596f526a22b474b15c376136772c00b8452f204d2d1::game::GameInfo, arg2: u64, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 3);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::string::utf8(b"WAVE_CLAIM_BOOST:");
        let v2 = 0x2::bcs::to_bytes<0x1::string::String>(&v1);
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<address>(&v0));
        let v3 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v3));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg2));
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.operator_pk, &v2) == true, 1);
        let v4 = 0x1::string::utf8(b"WAVE_CLAIM:");
        let v5 = 0x2::bcs::to_bytes<0x1::string::String>(&v4);
        0x1::vector::append<u8>(&mut v5, 0x2::bcs::to_bytes<u64>(&arg2));
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v5), 5);
        0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, v5, true);
        let v6 = BoostClaimed{
            receiver : v0,
            id       : arg2,
            level    : 0x1efaf509c9b7e986ee724596f526a22b474b15c376136772c00b8452f204d2d1::game::auth_upgrade_seafood(&mut arg0.id, arg1, 1, v0),
        };
        0x2::event::emit<BoostClaimed>(v6);
    }

    entry fun claim_genesis_nft(arg0: &mut App, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 3);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x1::string::utf8(b"WAVE_CLAIM_GENESIS_NFT:");
        let v2 = 0x2::bcs::to_bytes<0x1::string::String>(&v1);
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<address>(&v0));
        let v3 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v3));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg1));
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg0.operator_pk, &v2) == true, 1);
        let v4 = 0x1::string::utf8(b"WAVE_CLAIM:");
        let v5 = 0x2::bcs::to_bytes<0x1::string::String>(&v4);
        0x1::vector::append<u8>(&mut v5, 0x2::bcs::to_bytes<u64>(&arg1));
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v5), 5);
        0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, v5, true);
        0x2::transfer::public_transfer<0xb32dc6b71d2c13bb220957d0664b20b9b822c1deb48c930e6d112de9303f946a::wave_genesis_nft::NFT>(0xb32dc6b71d2c13bb220957d0664b20b9b822c1deb48c930e6d112de9303f946a::wave_genesis_nft::mint(&mut arg0.id, 0x1::string::into_bytes(0x1::string::utf8(b"Wave Genesis NFT")), 0x1::string::into_bytes(0x1::string::utf8(b"The Wave Genesis NFT provides access to future Launchpad events on WavePad. It facilitates whitelisting and maximizes allocation for upcoming rounds")), 0x1::string::into_bytes(0x1::string::utf8(b"https://file-walletapp.waveonsui.com/images/nfts/genesis.png")), 1, arg3), v0);
        let v6 = GenesisNftClaimed{
            receiver : v0,
            id       : arg1,
        };
        0x2::event::emit<GenesisNftClaimed>(v6);
    }

    entry fun claim_nft(arg0: &mut App, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u16, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 3);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::string::utf8(b"WAVE_CLAIM_NFT:");
        let v2 = 0x2::bcs::to_bytes<0x1::string::String>(&v1);
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<address>(&v0));
        let v3 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v3));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg1));
        let v4 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v4));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<vector<u8>>(&arg2));
        let v5 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v5));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<vector<u8>>(&arg3));
        let v6 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v6));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<vector<u8>>(&arg4));
        let v7 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v7));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u16>(&arg5));
        assert!(0x2::ed25519::ed25519_verify(&arg6, &arg0.operator_pk, &v2) == true, 1);
        let v8 = 0x1::string::utf8(b"WAVE_CLAIM:");
        let v9 = 0x2::bcs::to_bytes<0x1::string::String>(&v8);
        0x1::vector::append<u8>(&mut v9, 0x2::bcs::to_bytes<u64>(&arg1));
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v9), 5);
        0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, v9, true);
        0x2::transfer::public_transfer<0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::NFT>(0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::mint(&mut arg0.id, arg2, arg3, arg4, arg5, arg7), v0);
        let v10 = NftClaimed{
            receiver : v0,
            id       : arg1,
        };
        0x2::event::emit<NftClaimed>(v10);
    }

    entry fun claim_token<T0>(arg0: &mut App, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 3);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = type_to_bytes<T0>();
        let v2 = 0x1::string::utf8(b"WAVE_CLAIM_TOKEN:");
        let v3 = 0x2::bcs::to_bytes<0x1::string::String>(&v2);
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<address>(&v0));
        let v4 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x1::string::String>(&v4));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg1));
        let v5 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x1::string::String>(&v5));
        0x1::vector::append<u8>(&mut v3, v1);
        let v6 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x1::string::String>(&v6));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg2));
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.operator_pk, &v3) == true, 1);
        let v7 = 0x1::string::utf8(b"WAVE_CLAIM:");
        let v8 = 0x2::bcs::to_bytes<0x1::string::String>(&v7);
        0x1::vector::append<u8>(&mut v8, 0x2::bcs::to_bytes<u64>(&arg1));
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v8), 5);
        0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, v8, true);
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v1)) {
            abort 4
        };
        let v9 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1);
        assert!(0x2::balance::value<T0>(v9) >= arg2, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v9, arg2), arg4), v0);
        let v10 = TokenClaimed{
            receiver  : v0,
            coin_type : 0x1::string::utf8(v1),
            id        : arg1,
            amount    : arg2,
        };
        0x2::event::emit<TokenClaimed>(v10);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0xfdefe17a05a90060ef50ef578992df05f55ee11d31877d0c3010cbe36781f1b0;
        let v1 = App{
            id          : 0x2::object::new(arg0),
            operator_pk : 0x2::bcs::to_bytes<address>(&v0),
            version     : 1,
        };
        0x2::transfer::share_object<App>(v1);
        let v2 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v2, 0x2::tx_context::sender(arg0));
    }

    entry fun migrate(arg0: &OwnerCap, arg1: &mut App) {
        assert!(arg1.version < 1, 2);
        arg1.version = 1;
    }

    fun type_to_bytes<T0>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    entry fun update_operator(arg0: &OwnerCap, arg1: &mut App, arg2: vector<u8>) {
        arg1.operator_pk = arg2;
    }

    // decompiled from Move bytecode v6
}

