module 0xcd901fe8da787e1c385e307f34842441826aaa0272ca971b0051f3ba389dca0c::drb {
    struct DRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRB>(arg0, 9, b"DRB", b"Doctor Bak", b"To the Moon and the back ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ab20ca4d-4f12-4dc1-913e-8e76a40a01db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

