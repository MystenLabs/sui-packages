module 0x96ae4d137157d36bf2e56d66c2685769e72edba06f6265fcebfb25ea5d7d920c::oiai {
    struct OIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OIAI>(arg0, 6, b"OiAi", b"Oi Ai", x"4265206f6e65206f6620323030302070656f706c652e200a427579206f69616920546f6b656e20776974682031205375692e200a54686520667574757265206973204f6941692e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000085_942c2ab66d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OIAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OIAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

