module 0xeb735ddf23791c9284de3d3d1f3e4c82dbf1dce92a0f755f1dfeeba06961cb83::shrc {
    struct SHRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRC>(arg0, 6, b"SHRC", b"SharkRedChan", b"She represents the bold, fearless spirit of those who dive deep into the crypto waters, break barriers, and have fun while doing it. With SharkRedChan leading the way, SHRC holders can expect a thrilling adventure filled with humor, daring moves, and of course, sharp bites in the market!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Shark_Red_Chan_7141600cc5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

