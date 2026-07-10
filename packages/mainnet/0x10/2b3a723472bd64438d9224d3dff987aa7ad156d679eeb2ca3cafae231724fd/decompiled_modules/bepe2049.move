module 0x102b3a723472bd64438d9224d3dff987aa7ad156d679eeb2ca3cafae231724fd::bepe2049 {
    struct BEPE2049 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEPE2049, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEPE2049>(arg0, 6, b"BEPE2049", b"Bepe2049", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BEPE2049>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEPE2049>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BEPE2049>>(v2);
    }

    // decompiled from Move bytecode v6
}

