module 0xd7d3a3fb4ecf950c85f107c8a53d7e720e316c9ed9788c2a66efc0787c85f74f::beg {
    struct BEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEG>(arg0, 6, b"BEG", b"BEGN", b"LET'S GO TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1080x360_a9dfef367f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

