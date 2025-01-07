module 0x3cf38ed57d7ff6d385360d7a45cb82c936ab4628bb3303ceb10947ac9a372c98::stb {
    struct STB has drop {
        dummy_field: bool,
    }

    fun init(arg0: STB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STB>(arg0, 9, b"STB", b"Save the Bees", b"In response to the critical decline of bee populations worldwide, a unique digital asset called STB, also known as Save the Bees, has been launched. Its primary objective is to raise awareness about the plight of bees and promote their conservation, reflecting their integral role in our global ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STB>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STB>>(v1);
    }

    // decompiled from Move bytecode v6
}

