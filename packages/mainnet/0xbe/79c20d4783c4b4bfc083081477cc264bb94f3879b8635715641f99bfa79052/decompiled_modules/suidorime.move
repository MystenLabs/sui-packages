module 0xbe79c20d4783c4b4bfc083081477cc264bb94f3879b8635715641f99bfa79052::suidorime {
    struct SUIDORIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDORIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDORIME>(arg0, 6, b"SuiDorime", b"Dorime", b"Sui Dorime", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snipaste_2024_10_14_06_37_55_21aa5f36f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDORIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDORIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

