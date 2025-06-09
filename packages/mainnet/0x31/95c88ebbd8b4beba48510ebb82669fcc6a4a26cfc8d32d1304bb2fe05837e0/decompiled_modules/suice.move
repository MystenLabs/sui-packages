module 0x3195c88ebbd8b4beba48510ebb82669fcc6a4a26cfc8d32d1304bb2fe05837e0::suice {
    struct SUICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICE>(arg0, 6, b"SUICE", b"LUFFYCOIN", b"Set sail for the crypto Grand Line  LuffyCoin is here to stretch your gains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib5tr62n6poaewxewb4pzbpx2cs7hktcte4nncbkqn2hkjgvfxqj4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUICE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

