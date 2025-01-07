module 0x69548f038ecf515a3accbef6035b5628efeea03bb57ffd6eee93eb29351e934c::brettsui {
    struct BRETTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETTSUI>(arg0, 9, b"BRETTSUI", b"Brett Sui", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BRETTSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETTSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

