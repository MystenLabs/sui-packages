module 0x4416789a1f362e5b5704e65809a097433939aa916325f20f89d326d64d502236::ika_test {
    struct IKA_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: IKA_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IKA_TEST>(arg0, 9, b"IKA-TEST", b"IKA-TEST", b"IKA TEST TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.fullsail.finance/static_files/ika.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IKA_TEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IKA_TEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

