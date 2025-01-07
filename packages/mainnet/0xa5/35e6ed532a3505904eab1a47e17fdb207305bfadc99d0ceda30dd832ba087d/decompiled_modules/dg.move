module 0xa535e6ed532a3505904eab1a47e17fdb207305bfadc99d0ceda30dd832ba087d::dg {
    struct DG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DG>(arg0, 9, b"DG", b"rotdog", b"lets take dogs to another level of love", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1b054fa0-b42c-471b-9f0a-54e46d687d83.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DG>>(v1);
    }

    // decompiled from Move bytecode v6
}

