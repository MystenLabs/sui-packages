module 0xaf32e48278eb38ddf5768b26c71ff797d9416298d198940e21e49132ffc17b29::beatbot {
    struct BEATBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEATBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEATBOT>(arg0, 6, b"BeatBot", b"BeatBot on sui", b"If you are a music lover and want to experience a new type of investment, BeatBot could be an interesting choice.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_39391d3b01.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEATBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEATBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

