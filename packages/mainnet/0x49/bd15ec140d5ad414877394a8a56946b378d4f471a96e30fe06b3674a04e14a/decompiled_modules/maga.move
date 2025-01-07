module 0x49bd15ec140d5ad414877394a8a56946b378d4f471a96e30fe06b3674a04e14a::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA>(arg0, 9, b"MAGA", b"MAGA 2024", b"Official token of Trump 2024.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pridesource.com/archive/btl-db/images/2405/S1N_Trump_SQ_2405.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAGA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

