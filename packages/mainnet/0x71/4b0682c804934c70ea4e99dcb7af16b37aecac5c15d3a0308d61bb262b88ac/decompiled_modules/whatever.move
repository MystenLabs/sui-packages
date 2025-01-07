module 0x714b0682c804934c70ea4e99dcb7af16b37aecac5c15d3a0308d61bb262b88ac::whatever {
    struct WHATEVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHATEVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHATEVER>(arg0, 9, b"WHATEVER", b"whatever", b"whatever ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.lovethispic.com/uploaded_images/13568-Whatever.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHATEVER>>(v1);
        0x2::coin::mint_and_transfer<WHATEVER>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WHATEVER>>(v2);
    }

    // decompiled from Move bytecode v6
}

