module 0xd0e329e8f67681ae6555cb198b9f99a4927f5faa808780ac5a1dafd93be64f6e::last_test {
    struct LAST_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAST_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = vector[b"LAST_TEST", b"Last Test Coin", b"Just a last test coin", b"https://memez.gg"];
        let v1 = vector[b"LAST_TEST", b"Last Test Coin", b"Just a last test coin", b"https://memez.gg"];
        let v2 = vector[b"LAST_TEST", b"Last Test Coin", b"Just a last test coin", b"https://memez.gg"];
        let v3 = vector[b"LAST_TEST", b"Last Test Coin", b"Just a last test coin", b"https://memez.gg"];
        let (v4, v5) = 0x2::coin::create_currency<LAST_TEST>(arg0, 9, *0x1::vector::borrow<vector<u8>>(&v0, 0), *0x1::vector::borrow<vector<u8>>(&v1, 1), *0x1::vector::borrow<vector<u8>>(&v2, 2), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(*0x1::vector::borrow<vector<u8>>(&v3, 3))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAST_TEST>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAST_TEST>>(v5);
    }

    // decompiled from Move bytecode v6
}

