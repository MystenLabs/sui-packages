module 0xb8e5843f7795a5e4243f9345bbc510f7606fd58e63cb2f18ff8b0822a93e7043::gt {
    struct GT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GT>(arg0, 9, b"GT", b"Gee token ", b"Generally accepted token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/26b53a71-4c2e-4851-a929-0dc262e3d662.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GT>>(v1);
    }

    // decompiled from Move bytecode v6
}

