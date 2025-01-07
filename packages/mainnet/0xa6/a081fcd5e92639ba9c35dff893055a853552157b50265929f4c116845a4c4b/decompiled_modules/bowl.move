module 0xa6a081fcd5e92639ba9c35dff893055a853552157b50265929f4c116845a4c4b::bowl {
    struct BOWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOWL>(arg0, 6, b"BOWL", b"Blue Eyed Owl", b"A blue-eyed Owl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_09_073127_4655d0e065.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

