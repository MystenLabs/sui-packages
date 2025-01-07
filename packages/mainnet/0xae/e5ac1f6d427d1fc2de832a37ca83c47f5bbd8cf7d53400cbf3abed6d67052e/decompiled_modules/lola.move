module 0xaee5ac1f6d427d1fc2de832a37ca83c47f5bbd8cf7d53400cbf3abed6d67052e::lola {
    struct LOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLA>(arg0, 6, b"LOLA", b"LOLA", b"LOLA pair launch on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMhdzM6yn5fs-fH0xQ8l3PshYWgGL8cyCz4b17g81D1bqG200JYsJqCS4dBivuKntl24I&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LOLA>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

