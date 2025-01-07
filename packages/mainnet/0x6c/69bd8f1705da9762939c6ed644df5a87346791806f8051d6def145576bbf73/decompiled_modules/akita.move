module 0x6c69bd8f1705da9762939c6ed644df5a87346791806f8051d6def145576bbf73::akita {
    struct AKITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKITA>(arg0, 6, b"AKITA", b"AKITA on SUI", b"Hold $Akita become BILLIONAIRES!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0ge_HP_2_S_400x400_0e9180bdc3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

