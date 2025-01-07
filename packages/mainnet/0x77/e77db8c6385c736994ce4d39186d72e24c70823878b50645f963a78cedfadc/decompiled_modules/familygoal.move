module 0x77e77db8c6385c736994ce4d39186d72e24c70823878b50645f963a78cedfadc::familygoal {
    struct FAMILYGOAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAMILYGOAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAMILYGOAL>(arg0, 9, b"FAMILYGOAL", b"FAMILY ", b"Let's all commit to raising happy and responsible families.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed063686-8a87-4325-908b-be907e84d2c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAMILYGOAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAMILYGOAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

