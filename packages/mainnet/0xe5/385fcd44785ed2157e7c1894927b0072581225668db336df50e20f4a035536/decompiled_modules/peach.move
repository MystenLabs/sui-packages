module 0xe5385fcd44785ed2157e7c1894927b0072581225668db336df50e20f4a035536::peach {
    struct PEACH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEACH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEACH>(arg0, 6, b"PEACH", b"Peach Cat $SUI", x"546865204f6666696369616c2050656163682043617420546f6b656e204c61756e636820434845434b20414c4c20534f4349414c5320414e44204341732e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/openart_491a07f3a3bc46c1a0a86214acbff459_raw_6f26e76208.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEACH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEACH>>(v1);
    }

    // decompiled from Move bytecode v6
}

