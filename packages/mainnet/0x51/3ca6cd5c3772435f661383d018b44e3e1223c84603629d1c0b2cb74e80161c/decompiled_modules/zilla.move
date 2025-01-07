module 0x513ca6cd5c3772435f661383d018b44e3e1223c84603629d1c0b2cb74e80161c::zilla {
    struct ZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZILLA>(arg0, 6, b"ZILLA", b"SUI ZILLA", b"The Unofficial Sui Mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/85w_W7_B08_400x400_7cf95b0de2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

