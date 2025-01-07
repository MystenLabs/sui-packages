module 0x727c1b7c035a173f153dedc6c41b9a8322853b5d7145bb1dd4e68007faa897dd::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/1248857c-0823-4637-ab9f-8ed903af5f23/dinocoin.webp" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/1248857c-0823-4637-ab9f-8ed903af5f23/dinocoin.webp"))
        };
        let v1 = b"aDINO2";
        let v2 = b"bDino Coin 2";
        let v3 = b"cDino coin version 2 . Going to moon";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        0xc280be499d7831da76fa355666bb16f02f0ce8957f8a71418027cd35b5ea4edc::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 1500000000000, arg1);
    }

    // decompiled from Move bytecode v6
}

