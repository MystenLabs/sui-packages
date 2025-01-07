module 0x4b413e0dcac6c6505595bfc4783109a07f864b95f72caa4ae0159da840206724::met {
    struct MET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MET>(arg0, 6, b"MET", b"EL-ME", b"Siempre hay una salida.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/kn4oft_81c2321882.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MET>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MET>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

