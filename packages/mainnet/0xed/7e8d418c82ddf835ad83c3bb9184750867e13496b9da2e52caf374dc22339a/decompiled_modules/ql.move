module 0xed7e8d418c82ddf835ad83c3bb9184750867e13496b9da2e52caf374dc22339a::ql {
    struct QL has drop {
        dummy_field: bool,
    }

    fun init(arg0: QL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QL>(arg0, 9, b"QL", b"Quy Lao", x"517579206cc3a36f207469c3aa6e2073696e68", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe8f7d07-6dda-4e15-a761-861d067243b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QL>>(v1);
    }

    // decompiled from Move bytecode v6
}

