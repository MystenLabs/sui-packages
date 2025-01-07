module 0xdd791205f3365c3d9ddaa14e2daad183af738479fd8ecee50b457168b113f32::chillhippo {
    struct CHILLHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLHIPPO>(arg0, 6, b"CHILLHIPPO", b"CHILLHIPP", b"HIPPO ON SUIo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732386986738.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLHIPPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLHIPPO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

