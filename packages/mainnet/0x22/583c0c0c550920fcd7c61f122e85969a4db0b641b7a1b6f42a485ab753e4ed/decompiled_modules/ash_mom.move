module 0x22583c0c0c550920fcd7c61f122e85969a4db0b641b7a1b6f42a485ab753e4ed::ash_mom {
    struct ASH_MOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASH_MOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASH_MOM>(arg0, 6, b"ASH MOM", b"Ash ketchums mother", b"A collectible token representing Ash Ketchums mother from Pokemon. Invest to own a piece of Pokemon history and support the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreictkbfnssp7w34qwl2lhklb64ru6oep6oa4h64vabkcepgipdikze")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASH_MOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASH_MOM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

