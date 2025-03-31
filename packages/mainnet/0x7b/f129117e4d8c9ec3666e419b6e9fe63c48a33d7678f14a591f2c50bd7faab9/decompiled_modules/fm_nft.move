module 0x7bf129117e4d8c9ec3666e419b6e9fe63c48a33d7678f14a591f2c50bd7faab9::fm_nft {
    struct FMNFT has key {
        id: 0x2::object::UID,
        name: vector<u8>,
        description: vector<u8>,
        image_url: vector<u8>,
    }

    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        name: vector<u8>,
        description: vector<u8>,
        image_url: vector<u8>,
    }

    struct MintCap has key {
        id: 0x2::object::UID,
        minted: bool,
    }

    public fun transfer<T0: key>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun get_details(arg0: &FMNFT) : (vector<u8>, vector<u8>, vector<u8>) {
        (arg0.name, arg0.description, arg0.image_url)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCap{
            id     : 0x2::object::new(arg0),
            minted : false,
        };
        0x2::transfer::transfer<MintCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint(arg0: &mut MintCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.minted, 0);
        let v0 = FMNFT{
            id          : 0x2::object::new(arg5),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
        };
        arg0.minted = true;
        let v1 = MintEvent{
            nft_id      : 0x2::object::id<FMNFT>(&v0),
            name        : v0.name,
            description : v0.description,
            image_url   : v0.image_url,
        };
        0x2::event::emit<MintEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, 0x2::tx_context::sender(arg5));
        0x2::transfer::transfer<FMNFT>(v0, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

