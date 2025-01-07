module 0x680ee59a7064b4a81587c9d99f72957d0b88c6d925a1d32b47f45b1738052f16::elpa {
    struct ELPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELPA>(arg0, 6, b"ELPA", b"Sui Elpa", b"All you hear is Elpa, Elpa, Elpa, Elpa and Elpa. They wont stfu about Elpa. You know why? Cause $ELPA is HIM.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/iuhiuy_b40e734473.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

