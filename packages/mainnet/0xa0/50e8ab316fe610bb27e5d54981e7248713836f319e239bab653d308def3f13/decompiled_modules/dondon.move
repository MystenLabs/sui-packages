module 0xa050e8ab316fe610bb27e5d54981e7248713836f319e239bab653d308def3f13::dondon {
    struct DONDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONDON>(arg0, 9, b"DONDON", b"DinDinDon", b"DinDinDon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a0d78700-3f90-4c45-b448-c7a706194616.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

