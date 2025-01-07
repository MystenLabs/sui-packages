module 0xdaa22f7545d8cc9f30914341ef1bdced3824b6c0ea24923e42eb11ca07a83ee8::brz {
    struct BRZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRZ>(arg0, 9, b"BRZ", b"BorzCoin ", b"Coin for real man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7dee58e-f155-490a-8c2d-67f2c70146d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

