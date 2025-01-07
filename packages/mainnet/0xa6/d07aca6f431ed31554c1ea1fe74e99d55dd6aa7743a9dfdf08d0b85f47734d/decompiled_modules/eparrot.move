module 0xa6d07aca6f431ed31554c1ea1fe74e99d55dd6aa7743a9dfdf08d0b85f47734d::eparrot {
    struct EPARROT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPARROT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPARROT>(arg0, 9, b"EPARROT", b"Talha", b"My Name Is Talha Aslam And I have a student.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0acb206a-61dc-43b9-9dff-50a1a99c72b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPARROT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EPARROT>>(v1);
    }

    // decompiled from Move bytecode v6
}

