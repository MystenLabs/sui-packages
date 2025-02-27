module 0x405d22c8915e6b6b23f6f4953389eb74748bd1194965ed7a58e56e3e3515fe72::tfa {
    struct TFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TFA>(arg0, 6, b"TFA", b"The First Arrest", x"546865206669727374206172726573742077696c6c2073686f636b2074686520776f726c642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/35f1f4d0_f4d7_11ef_8c03_7dfdbeeb2526_7384539a05.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

