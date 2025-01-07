module 0x1d4d10c677bbb678af307ce3ba78e0d283a915f0a57b331c84679a0c33f9d4aa::jui {
    struct JUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUI>(arg0, 6, b"JUI", b"JEWS UNWELCOMED INC.", x"4a45575320554e57454c434f4d454420494e432e0a0a594f555220534f5552434520464f5220414e544553454d495449534d2120415045204e4f572e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730973218948.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

