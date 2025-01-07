module 0x6383b9071b6418541d550f758af025e3b894ca53c740d3ff4ae1faf3336ae388::sbear {
    struct SBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBEAR>(arg0, 6, b"SBEAR", b"SUIDOBEAR", b"Mutant Pedobear on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PENUP_20241203_214038_90caa90c1d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

