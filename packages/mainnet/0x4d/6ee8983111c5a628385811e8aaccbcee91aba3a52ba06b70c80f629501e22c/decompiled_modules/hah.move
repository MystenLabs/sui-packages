module 0x4d6ee8983111c5a628385811e8aaccbcee91aba3a52ba06b70c80f629501e22c::hah {
    struct HAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAH>(arg0, 9, b"HAH", b"haha", x"484148414841484120f09f9884f09f9884f09f9884", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cc6eb484-d0f1-421d-87c3-f120072305d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

