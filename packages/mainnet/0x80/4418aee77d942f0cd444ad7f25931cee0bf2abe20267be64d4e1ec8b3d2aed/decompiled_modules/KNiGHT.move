module 0x804418aee77d942f0cd444ad7f25931cee0bf2abe20267be64d4e1ec8b3d2aed::KNiGHT {
    struct KNIGHT has drop {
        dummy_field: bool,
    }

    struct MintTracker has store, key {
        id: 0x2::object::UID,
        total_minted: u64,
        owner: address,
        paused: bool,
    }

    struct TokenMetadata has store, key {
        id: 0x2::object::UID,
        image_url: vector<u8>,
        description: vector<u8>,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"KNiGHT", b"KNiGHT TiME", b"Knight Time is an NFT VR and AR project built for gaming.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: KNIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<KNIGHT>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = MintTracker{
            id           : 0x2::object::new(arg1),
            total_minted : 0,
            owner        : v1,
            paused       : false,
        };
        0x2::transfer::public_transfer<MintTracker>(v2, v1);
        let v3 = TokenMetadata{
            id          : 0x2::object::new(arg1),
            image_url   : b"https://i.seadn.io/s/raw/files/dfb2bf9b18589ae00f7364410b8b7bd9.jpg?auto=format&dpr=1&w=1920",
            description : b"Knight Time is an NFT VR and AR project built for gaming.",
        };
        0x2::transfer::public_transfer<TokenMetadata>(v3, v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNIGHT>>(v0, v1);
    }

    public entry fun set_description(arg0: &mut TokenMetadata, arg1: &MintTracker, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg3) != arg1.owner) {
            abort 3
        };
        arg0.description = arg2;
    }

    public entry fun set_image_url(arg0: &mut TokenMetadata, arg1: &MintTracker, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg3) != arg1.owner) {
            abort 2
        };
        arg0.image_url = arg2;
    }

    // decompiled from Move bytecode v6
}

