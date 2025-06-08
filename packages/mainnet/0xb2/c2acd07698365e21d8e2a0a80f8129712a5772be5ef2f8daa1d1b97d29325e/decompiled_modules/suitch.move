module 0xb2c2acd07698365e21d8e2a0a80f8129712a5772be5ef2f8daa1d1b97d29325e::suitch {
    struct SUITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITCH>(arg0, 6, b"SUITCH", b"Nintendo Suitch", b"ITS THE NINTENDO SWITCH 2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeig76abfwag22g2w74npm6sxoxbh6yhex2dp6vbubifu6nanqjrxlq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUITCH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

