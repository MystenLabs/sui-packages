module 0x2306966484c14c6703a0874bd1e66c080ca0aa2a6d46cf792285fcb9a59d5307::hana {
    struct HANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANA>(arg0, 6, b"HANA", b"HANA AI", b"HANA AI hi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CHIBI_5775827001.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

