module 0x8a12b3db58aee4688f4c119d77571e6decad9d1c1b344f22b45783c0363f0e3d::HANBAO {
    struct HANBAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANBAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANBAO>(arg0, 2, b"HANBAO", b"HANBAO", b"SUIWAVE is revolutionizing the SUI crypto space with the first volume bot on the SUI eco system.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Fphoto_2024_10_10_00_54_39_fcfead47a7.jpg&w=256&q=75")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HANBAO>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HANBAO>(&mut v2, 50000000001, @0x7aed1e213e4ed1b16234506f0e78d94bbb3cf60967540beb841d14d3607b09c4, arg1);
        0x2::coin::mint_and_transfer<HANBAO>(&mut v2, 50000000000, @0x7aed1e213e4ed1b16234506f0e78d94bbb3cf60967540beb841d14d3607b09c4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANBAO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

