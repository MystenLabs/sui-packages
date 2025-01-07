module 0xbe72773c4d2941b6be4827d248ab598846a0e347e658047d0cc27d8325784724::dpd {
    struct DPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPD>(arg0, 6, b"DPD", b"Dramatic Prairie Dog", b"OG internet meme, Dramatic Prairie Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_06_133935_9bd8b998d2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DPD>>(v1);
    }

    // decompiled from Move bytecode v6
}

