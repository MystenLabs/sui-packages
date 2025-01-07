module 0x46073f89c7e8d80ced2f73243034f0d9d5241f1e69faa06fb776bf7218c2b53a::cucu {
    struct CUCU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUCU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUCU>(arg0, 9, b"CUCU", b"Cucurut", b"Future memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ad4522c-3ef9-40a4-9d61-ef0ef3fcd9e2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUCU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUCU>>(v1);
    }

    // decompiled from Move bytecode v6
}

