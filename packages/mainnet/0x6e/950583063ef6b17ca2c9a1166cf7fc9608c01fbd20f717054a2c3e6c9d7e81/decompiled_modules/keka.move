module 0x6e950583063ef6b17ca2c9a1166cf7fc9608c01fbd20f717054a2c3e6c9d7e81::keka {
    struct KEKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKA>(arg0, 6, b"KEKA", b"KEKA ON SUI", b"KEKA is more than a cryptocurrency; is a symbol of innovation and community in a constantly evolving digital world. Inspired by futuristic spirit and advanced technology, KEKA combines security, sustainability and accessibility to revolutionize the way we interact with digital assets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_01_21_05_13d7e94843.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

