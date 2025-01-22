module 0xb32b7a8b227749cd72a495675512548accaa1834c5b65abaf60d135c891ddfb9::mana {
    struct MANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANA>(arg0, 9, b"MANA", b"MANA", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/cGfIa0iHEOi_AWjFgONf3pab0Qi1jcy1p4iz9cn0PYM")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MANA>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANA>>(v2, @0xb3c4e86b594ffd2635800a23b5014e6b696ed958ea673111f07adcc62ac8e9be);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

