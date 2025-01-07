module 0x6a16b988ab7381d5af1b06ad9f9fa410bc969778b23c6e2dca3b09595b2315b7::hpump {
    struct HPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HPUMP>(arg0, 6, b"HPUMP", b"Hallowed Pump on Sui", b"Pump it like a jack-o-lantern.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hallowen_a126334255.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

