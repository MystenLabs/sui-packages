module 0x7505e969e0c0bdf7a512e810590f44134abd32aa7b9540ba979a425338034d15::bh {
    struct BH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BH>(arg0, 9, b"BH", b"Bishop ", b"Protector of the sui clan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6b0fe17c-cfca-460e-b7e4-8e47cd6d6f7b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BH>>(v1);
    }

    // decompiled from Move bytecode v6
}

