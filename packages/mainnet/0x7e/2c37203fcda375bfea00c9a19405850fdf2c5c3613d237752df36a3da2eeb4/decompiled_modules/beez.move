module 0x7e2c37203fcda375bfea00c9a19405850fdf2c5c3613d237752df36a3da2eeb4::beez {
    struct BEEZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEEZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEEZ>(arg0, 9, b"BEEZ", b"BEEZ", b"The Beez", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BEEZ>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEEZ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEEZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

