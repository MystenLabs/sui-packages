module 0x80d36a74edb515016466f0f7f182ad677e8c26c7724cc8e18b68c4271f072a8e::don {
    struct DON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DON>(arg0, 9, b"DON", b"Domins", x"4920646f6ee2809974206b6e6f77207768617420796f752061726520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6cf68045-20f3-438f-b169-a7b6ee3379ea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DON>>(v1);
    }

    // decompiled from Move bytecode v6
}

