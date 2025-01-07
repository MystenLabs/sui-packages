module 0x7588f65277c3ded3514c483639d8f75bf21a6233bb5a48428c26753fad1ca8f4::sinkjni {
    struct SINKJNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINKJNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINKJNI>(arg0, 6, b"SINKJNI", b"sink", x"610a73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732482541115.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SINKJNI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINKJNI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

