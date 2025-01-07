module 0xd94876e8bf4a088d9e7fc8da86c274ab3a1ea148491265f10d78d2edcb3621e::pn {
    struct PN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PN>(arg0, 9, b"PN", b"PINOO", b"Love my child", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5fc4ee91-ff26-46b1-8e0b-1d24ca5d21ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PN>>(v1);
    }

    // decompiled from Move bytecode v6
}

