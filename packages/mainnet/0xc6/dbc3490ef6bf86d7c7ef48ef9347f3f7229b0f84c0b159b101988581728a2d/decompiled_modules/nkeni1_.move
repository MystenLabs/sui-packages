module 0xc6dbc3490ef6bf86d7c7ef48ef9347f3f7229b0f84c0b159b101988581728a2d::nkeni1_ {
    struct NKENI1_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NKENI1_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NKENI1_>(arg0, 9, b"NKENI1_", b"Phil ", x"4372656174696e67207765616c746820746f206d616b65206c6966652062657474657220666f72206d6520616e64206d79206c6f7665206f6e657320e29da3efb88ff09fa4a92e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/203a04af-4055-4c87-b049-0a28bfef7cbc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NKENI1_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NKENI1_>>(v1);
    }

    // decompiled from Move bytecode v6
}

