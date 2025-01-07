module 0x81fdaa70d8dcde708c9a141f3ca1f91b7044ad53463cb381448773888cdd1c1d::spongebob {
    struct SPONGEBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONGEBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONGEBOB>(arg0, 9, b"SPONGEBOB", b"WAVE", b"Just for fun :)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fbbde7cb-cc8a-414f-a486-aacef62a7553.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONGEBOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPONGEBOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

