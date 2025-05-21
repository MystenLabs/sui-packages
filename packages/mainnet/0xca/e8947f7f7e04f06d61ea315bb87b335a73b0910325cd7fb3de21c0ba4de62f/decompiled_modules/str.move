module 0xcae8947f7f7e04f06d61ea315bb87b335a73b0910325cd7fb3de21c0ba4de62f::str {
    struct STR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STR>(arg0, 9, b"STR", b"SUI Trench Rooms", b"bringing life to trenches", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbYHhZjyPeoHzhc3J3yibQrQCT7AhphifaoDJusgkEfSi")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STR>(&mut v2, 1000000000000000000, @0x3004d90dae38a1f9f6e9890aa7332c5679cc7ae59d69940a55fe8a27711937f3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STR>>(v1);
    }

    // decompiled from Move bytecode v6
}

