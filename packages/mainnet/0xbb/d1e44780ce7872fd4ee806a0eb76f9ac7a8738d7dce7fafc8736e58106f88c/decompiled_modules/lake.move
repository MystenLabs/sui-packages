module 0xbbd1e44780ce7872fd4ee806a0eb76f9ac7a8738d7dce7fafc8736e58106f88c::lake {
    struct LAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAKE>(arg0, 6, b"Lake", b"DragonLake on Sui", x"42656c6965766520696e20736f6d657468696e670a0a42656c6965766520696e20244c414b45", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiftjrn3sjrgwq5pvasaec3m3cvfvnkp4r7m7xcnizmp2szcv7lk7q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LAKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

