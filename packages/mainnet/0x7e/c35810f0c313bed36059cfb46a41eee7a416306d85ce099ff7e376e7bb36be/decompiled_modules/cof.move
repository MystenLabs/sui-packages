module 0x7ec35810f0c313bed36059cfb46a41eee7a416306d85ce099ff7e376e7bb36be::cof {
    struct COF has drop {
        dummy_field: bool,
    }

    fun init(arg0: COF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COF>(arg0, 9, b"COF", b"Coffee", x"4265737420f09f918c20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/35d4c47d-13ae-4f2f-8f97-64ca39f51349.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COF>>(v1);
    }

    // decompiled from Move bytecode v6
}

