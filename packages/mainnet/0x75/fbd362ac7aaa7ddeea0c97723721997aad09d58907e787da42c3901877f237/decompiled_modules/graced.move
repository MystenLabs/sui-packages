module 0x75fbd362ac7aaa7ddeea0c97723721997aad09d58907e787da42c3901877f237::graced {
    struct GRACED has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRACED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRACED>(arg0, 9, b"GRACED", b"Gospel sav", b"CHRIST DIED FOR SINNERS, WE ARE FORGIVEN IN HIM.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e55bfbf7-92ab-4d91-a586-2be8cd5904bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRACED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRACED>>(v1);
    }

    // decompiled from Move bytecode v6
}

