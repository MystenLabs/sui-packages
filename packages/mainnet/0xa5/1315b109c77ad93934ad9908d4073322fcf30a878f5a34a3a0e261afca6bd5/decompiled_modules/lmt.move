module 0xa51315b109c77ad93934ad9908d4073322fcf30a878f5a34a3a0e261afca6bd5::lmt {
    struct LMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMT>(arg0, 9, b"LMT", b"Luka Modri", b"Luka Modric MT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0342dd57-de28-4c9d-8cb8-7048bf3c7d15.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LMT>>(v1);
    }

    // decompiled from Move bytecode v6
}

