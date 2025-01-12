module 0x1e0fbab60c9a20dc932969d5645e17ab63c4505f5004bad0b25aed2d5871f996::hmk {
    struct HMK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMK>(arg0, 9, b"HMK", b"HOMIAKY", b"The coin is designed to fall", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8972fbd7-e730-43e6-a025-8018cfa5afae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HMK>>(v1);
    }

    // decompiled from Move bytecode v6
}

