module 0x83c3dd0913c7a3cfe3524d8a3aaa7a488434771bef6a8ed5d503548cbd463630::kumo_meme_airdrop {
    struct KUMO_MEME_AIRDROP has drop {
        dummy_field: bool,
    }

    struct KumoAirdrop has store, key {
        id: 0x2::object::UID,
        allocation: u64,
        claimed: bool,
    }

    struct KumoAirdropMintAuth has store, key {
        id: 0x2::object::UID,
        mint_count: u64,
    }

    struct KumoAirdropManager<phantom T0> has store, key {
        id: 0x2::object::UID,
        tokens: 0x2::balance::Balance<T0>,
    }

    struct KumoAirdropMintedEvent has copy, drop {
        id: 0x2::object::ID,
        allocation: u64,
    }

    struct KumoAirdropClaimedEvent has copy, drop {
        id: 0x2::object::ID,
        allocation: u64,
    }

    struct KumoAirdropTokensAddedEvent has copy, drop {
        id: 0x2::object::ID,
        amount: u64,
        from: address,
    }

    public entry fun claim<T0>(arg0: &mut KumoAirdropManager<T0>, arg1: &mut KumoAirdrop, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.claimed == false, 1);
        assert!(arg1.allocation <= 0x2::balance::value<T0>(&arg0.tokens), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.tokens, arg1.allocation), arg2), 0x2::tx_context::sender(arg2));
        arg1.claimed = true;
        let v0 = KumoAirdropClaimedEvent{
            id         : 0x2::object::id<KumoAirdrop>(arg1),
            allocation : arg1.allocation,
        };
        0x2::event::emit<KumoAirdropClaimedEvent>(v0);
    }

    public entry fun add_tokens_to_manager<T0>(arg0: &mut KumoAirdropManager<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3);
        0x2::balance::join<T0>(&mut arg0.tokens, 0x2::coin::into_balance<T0>(arg1));
        let v1 = KumoAirdropTokensAddedEvent{
            id     : 0x2::object::id<KumoAirdropManager<T0>>(arg0),
            amount : v0,
            from   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<KumoAirdropTokensAddedEvent>(v1);
    }

    public entry fun create_manager<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<KumoAirdrop>(arg0), 0);
        let v0 = KumoAirdropManager<T0>{
            id     : 0x2::object::new(arg1),
            tokens : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::public_share_object<KumoAirdropManager<T0>>(v0);
    }

    fun init(arg0: KUMO_MEME_AIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<KUMO_MEME_AIRDROP>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Kumo Airdrop"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://lk-web3-dashboard.vercel.app/api/rendermemecoin?allocation={allocation}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Gmeow! The meme has entered the wallet."));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://kumothekat.com"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Lucky Kat Studios"));
        let v6 = 0x2::display::new_with_fields<KumoAirdrop>(&v1, v2, v4, arg1);
        0x2::display::update_version<KumoAirdrop>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<KumoAirdrop>>(v6, v0);
        let v7 = KumoAirdropMintAuth{
            id         : 0x2::object::new(arg1),
            mint_count : 0,
        };
        0x2::transfer::public_transfer<KumoAirdropMintAuth>(v7, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
    }

    public fun mint_auth_to_address(arg0: &0x2::package::Publisher, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<KumoAirdrop>(arg0), 0);
        let v0 = KumoAirdropMintAuth{
            id         : 0x2::object::new(arg2),
            mint_count : 0,
        };
        0x2::transfer::public_transfer<KumoAirdropMintAuth>(v0, arg1);
    }

    public fun mint_to_address(arg0: &mut KumoAirdropMintAuth, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = KumoAirdrop{
            id         : 0x2::object::new(arg3),
            allocation : arg1,
            claimed    : false,
        };
        arg0.mint_count = arg0.mint_count + 1;
        let v1 = KumoAirdropMintedEvent{
            id         : 0x2::object::id<KumoAirdrop>(&v0),
            allocation : v0.allocation,
        };
        0x2::event::emit<KumoAirdropMintedEvent>(v1);
        0x2::transfer::public_transfer<KumoAirdrop>(v0, arg2);
    }

    public entry fun mutate_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<KumoAirdrop>) {
        assert!(0x2::package::from_package<KumoAirdrop>(arg0), 0);
        0x2::display::edit<KumoAirdrop>(arg3, arg1, arg2);
        0x2::display::update_version<KumoAirdrop>(arg3);
    }

    // decompiled from Move bytecode v6
}

