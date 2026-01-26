module 0xe65156eb6e9c034a7c210ce33ee67673cdfe944540a8beb4701ca748d538dfc6::gud {
    struct GUD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GUD>, arg1: 0x2::coin::Coin<GUD>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<GUD>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GUD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GUD>>(0x2::coin::mint<GUD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<GUD>(arg0, 9, b"FUD", b"FUD", x"46554420e2809420476f6f64205669626573204f6e6c792e20546865206f70706f73697465206f66204655442c207075726520706f7369746976697479206d656d6520636f696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coin-images.coingecko.com/coins/images/33610/large/pug-head.png?1702513072")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUD>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<GUD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<GUD>>(v0);
    }

    // decompiled from Move bytecode v6
}

