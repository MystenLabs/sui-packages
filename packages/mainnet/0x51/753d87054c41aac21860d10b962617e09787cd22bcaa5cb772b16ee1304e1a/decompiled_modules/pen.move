module 0x51753d87054c41aac21860d10b962617e09787cd22bcaa5cb772b16ee1304e1a::pen {
    struct PEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEN>(arg0, 9, b"PEN", b"hsjs", b"jend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/51133eeb-d2cb-405c-a718-d8788b4d208d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

