module 0xda522a55fed7bdc1235207dba37dbf6f5c5aeab59c050e1d04233f69544a2b88::orange {
    struct ORANGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORANGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORANGE>(arg0, 9, b"ORANGE", b"ORANGE", b"An orange orange", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ORANGE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORANGE>>(v2, @0x510dcde7570ca35fa478cbe0b65d27fec1e866c0538a83822a25d5463974141d);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORANGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

