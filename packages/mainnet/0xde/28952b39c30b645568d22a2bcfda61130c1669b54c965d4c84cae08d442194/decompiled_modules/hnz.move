module 0xde28952b39c30b645568d22a2bcfda61130c1669b54c965d4c84cae08d442194::hnz {
    struct HNZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HNZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HNZ>(arg0, 9, b"HNZ", b"Hunza", b"This token is made for promote tourism in Gilgitbaltistan. Beautiful landscape amazing people and natural lakes etc .. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2fd4e268-b89a-4014-a6ee-0581cc126070.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HNZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HNZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

