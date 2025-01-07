module 0x1462c63c09a49d47895b0c76b17615bc120cc4b0092455bcfd6d2160776f1c66::lcc {
    struct LCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LCC>(arg0, 9, b"LCC", b"LEOCATCOIN", b"LEOCATCOIN GOING TO BE THE BIGGEST OF THE MEMES COINS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/247bca3b-421d-4678-8dd6-b65976db1521.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

