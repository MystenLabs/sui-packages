module 0x1c9b8731b89eb2559a52c87e6f0a525d234ee45bf4dbed2cd275bd6e70f6de55::dope {
    struct DOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPE>(arg0, 6, b"DOPE", b"Dope the Dolphin", b"just a little dolphin on $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/P_Pdope_b80e23d711.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

