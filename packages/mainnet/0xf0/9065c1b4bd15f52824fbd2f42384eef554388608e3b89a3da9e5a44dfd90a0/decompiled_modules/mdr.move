module 0xf09065c1b4bd15f52824fbd2f42384eef554388608e3b89a3da9e5a44dfd90a0::mdr {
    struct MDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDR>(arg0, 9, b"MDR", b"MEME DOLLA", b"Meme for all USDT users. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6359ac16-a2c8-489b-bf34-47690e036cca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDR>>(v1);
    }

    // decompiled from Move bytecode v6
}

