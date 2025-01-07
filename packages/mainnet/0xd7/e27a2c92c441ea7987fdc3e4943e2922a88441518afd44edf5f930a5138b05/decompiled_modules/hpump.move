module 0xd7e27a2c92c441ea7987fdc3e4943e2922a88441518afd44edf5f930a5138b05::hpump {
    struct HPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HPUMP>(arg0, 6, b"Hpump", b"happy with trump", b"get happy with trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ha_143d593c3e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

