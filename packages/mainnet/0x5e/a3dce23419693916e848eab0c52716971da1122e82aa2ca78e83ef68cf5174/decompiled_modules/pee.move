module 0x5ea3dce23419693916e848eab0c52716971da1122e82aa2ca78e83ef68cf5174::pee {
    struct PEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEE>(arg0, 9, b"PEE", b"pine tree", b"evergreen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d97bb329-50fe-41c2-b46e-73dcc6b7b7cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

