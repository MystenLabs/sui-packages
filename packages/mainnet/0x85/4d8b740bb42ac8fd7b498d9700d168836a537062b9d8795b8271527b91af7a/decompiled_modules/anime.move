module 0x854d8b740bb42ac8fd7b498d9700d168836a537062b9d8795b8271527b91af7a::anime {
    struct ANIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANIME>(arg0, 6, b"ANIME", b"ANIME SUI", x"416e696d65206c6f766572732c206d65657420416e696d6520436f696e2120f09faa99200a546865206469676974616c206d656d6520636f696e20666f7220616e696d652066616e732e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731909337093.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANIME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANIME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

