module 0xa10aa03771ebbb45c37b30558589b6b94d160173d7919801c11acff122371515::pussui {
    struct PUSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSSUI>(arg0, 6, b"PUSSUI", b"Pink little pussui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvU4PvT6D5NUscWb8YILlw2KZYwJpyyGAkAQ&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUSSUI>(&mut v2, 55555555555000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUSSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

