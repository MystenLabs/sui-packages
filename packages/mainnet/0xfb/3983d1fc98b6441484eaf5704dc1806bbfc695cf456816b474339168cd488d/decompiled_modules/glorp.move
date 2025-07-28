module 0xfb3983d1fc98b6441484eaf5704dc1806bbfc695cf456816b474339168cd488d::glorp {
    struct GLORP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLORP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLORP>(arg0, 6, b"GLORP", b"Glorp", b"Foint glorp, zibzip uzuzu glorp mimimi glorp glorp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1753707896355.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLORP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLORP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

