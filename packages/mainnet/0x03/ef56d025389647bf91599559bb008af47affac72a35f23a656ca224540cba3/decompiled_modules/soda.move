module 0x3ef56d025389647bf91599559bb008af47affac72a35f23a656ca224540cba3::soda {
    struct SODA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SODA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SODA>(arg0, 6, b"SODA", b"SUI SODA", b"$SODA | Fizzy Memecoins in the SUI Ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000085993_5c4e64fe18.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SODA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SODA>>(v1);
    }

    // decompiled from Move bytecode v6
}

