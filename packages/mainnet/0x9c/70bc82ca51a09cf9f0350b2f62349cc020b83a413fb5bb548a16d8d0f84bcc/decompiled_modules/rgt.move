module 0x9c70bc82ca51a09cf9f0350b2f62349cc020b83a413fb5bb548a16d8d0f84bcc::rgt {
    struct RGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RGT>(arg0, 9, b"RGT", b"Regent", b"Be Brave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5994a8ca-2f46-4baa-a21b-a0b2d24ca809.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

