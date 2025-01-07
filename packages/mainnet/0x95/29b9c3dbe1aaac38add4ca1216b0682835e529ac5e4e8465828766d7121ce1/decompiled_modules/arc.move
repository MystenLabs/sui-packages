module 0x9529b9c3dbe1aaac38add4ca1216b0682835e529ac5e4e8465828766d7121ce1::arc {
    struct ARC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARC>(arg0, 9, b"ARC", b"arcane", b"ARCEANE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b4570c30-b026-4094-abf4-f44eb2c5444f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARC>>(v1);
    }

    // decompiled from Move bytecode v6
}

