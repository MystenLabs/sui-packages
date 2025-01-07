module 0xa964dfa35faba758bba958e3092610d9f4cf9253d34f3884e0c2fdec0bc1ca27::suilen {
    struct SUILEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILEN>(arg0, 6, b"SUILEN", b"LEN ON SUI", b"In honour of Len Sassaman the immortal. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000023421_58f6e94f74.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

