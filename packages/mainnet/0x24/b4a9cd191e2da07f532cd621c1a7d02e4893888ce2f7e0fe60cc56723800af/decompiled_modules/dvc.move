module 0x24b4a9cd191e2da07f532cd621c1a7d02e4893888ce2f7e0fe60cc56723800af::dvc {
    struct DVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DVC>(arg0, 9, b"DVC", b"Devilcoin", b"Devilcoin is a meme coin driven by community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/538774c2-9d05-45c4-ab87-6872a364e6ad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DVC>>(v1);
    }

    // decompiled from Move bytecode v6
}

