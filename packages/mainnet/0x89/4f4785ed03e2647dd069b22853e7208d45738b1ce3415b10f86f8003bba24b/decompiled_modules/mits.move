module 0x894f4785ed03e2647dd069b22853e7208d45738b1ce3415b10f86f8003bba24b::mits {
    struct MITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MITS>(arg0, 6, b"MITS", b"MITSUKO", b"Mitsuko army ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mitsuko_824fc24486.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

