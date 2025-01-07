module 0xf1f65c303f3aa26657c46f1bd7fae69190cb4b0496c5b1a68b938a3afca8ce6d::satwewe {
    struct SATWEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATWEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATWEWE>(arg0, 9, b"SATWEWE", b"Satoshi We", b"Satoshi Wewe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ba11d30c-ed17-40ad-9290-291f9c14bdd7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATWEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SATWEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

