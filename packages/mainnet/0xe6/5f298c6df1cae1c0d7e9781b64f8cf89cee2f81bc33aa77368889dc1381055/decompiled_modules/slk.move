module 0xe65f298c6df1cae1c0d7e9781b64f8cf89cee2f81bc33aa77368889dc1381055::slk {
    struct SLK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLK>(arg0, 9, b"SLK", b"ByTheSLK", b"This Token, is the Token who represente my YouTube channel. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7f73fc9d-80c6-43b7-aa58-561d10b1a429.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLK>>(v1);
    }

    // decompiled from Move bytecode v6
}

