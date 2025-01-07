module 0x9d8ef37990fefb72b4949fb424019ba9f4768d4c57a42e590aafdeaee8ccac22::crow {
    struct CROW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROW>(arg0, 6, b"CROW", b"Crow on SUI", b"The crow, enemy to farmers and jeets from the beginning of time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yhx_Mro5_S_400x400_51a9a2d3ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROW>>(v1);
    }

    // decompiled from Move bytecode v6
}

