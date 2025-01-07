module 0x34961b9ead975d94c312f97d98ff7c1d6e110513a5f13587765c8b0b4069c90a::magafin {
    struct MAGAFIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAFIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGAFIN>(arg0, 6, b"MAGAFIN", b"MAGAfin", b"Vote TRUMP or MAGAFIN will judge you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MAGAFIN_587112c026.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGAFIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGAFIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

