module 0x67a8e29e548a0d5a841a4d4d7c89fcbbcc6eae9420484dfb2fe586db9ea175bf::str {
    struct STR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STR>(arg0, 9, b"STR", b"Sui Trench Rooms", b"bringing life to trenches", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbYHhZjyPeoHzhc3J3yibQrQCT7AhphifaoDJusgkEfSi")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

