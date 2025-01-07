module 0x41a82098ab01bd8c9ecfeb6bd751fb59784b626405d7c78e99e7243c01583b5a::tusk {
    struct TUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUSK>(arg0, 6, b"TUSK", b"Tusk the Walrus", b"Tusk the Walrus On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tusk_6a8ded65fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

