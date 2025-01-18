module 0xf37ecb587e921ed158e27e1c52f8928dff0e3d3f49b8e987db974266e3eb0af2::trump2 {
    struct TRUMP2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP2>(arg0, 6, b"TRUMP2", b"trump", b"donald trump fan meme token half of the tokens will be distributed as airdrop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737231754170.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

