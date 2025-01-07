module 0xca92f250e84c9929876c1bfffe3c264841e9e670231fe5f1f1a3cc0831b9b0d7::amaga {
    struct AMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMAGA>(arg0, 9, b"AMAGA", b"AMAGA", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDNcHDk07OpXCO1Q1PhusMhnZTRBflChuAaw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AMAGA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMAGA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

