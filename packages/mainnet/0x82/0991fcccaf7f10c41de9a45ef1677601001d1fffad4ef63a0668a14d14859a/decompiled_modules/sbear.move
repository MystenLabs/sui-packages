module 0x820991fcccaf7f10c41de9a45ef1677601001d1fffad4ef63a0668a14d14859a::sbear {
    struct SBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBEAR>(arg0, 6, b"SBEAR", b"SUIDOBEAR", b"Mutant Pedobear in SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PENUP_20241203_214038_38528bde2b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

