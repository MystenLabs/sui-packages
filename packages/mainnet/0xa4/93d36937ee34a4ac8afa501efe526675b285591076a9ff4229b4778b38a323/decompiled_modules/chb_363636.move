module 0xa493d36937ee34a4ac8afa501efe526675b285591076a9ff4229b4778b38a323::chb_363636 {
    struct CHB_363636 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHB_363636, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHB_363636>(arg0, 9, b"CHB_363636", b"Pink", b"To the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86d5a592-8171-4c6b-a1c0-f3d8cca85752.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHB_363636>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHB_363636>>(v1);
    }

    // decompiled from Move bytecode v6
}

