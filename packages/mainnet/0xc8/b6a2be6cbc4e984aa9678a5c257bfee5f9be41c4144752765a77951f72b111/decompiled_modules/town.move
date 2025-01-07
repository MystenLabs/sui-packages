module 0xc8b6a2be6cbc4e984aa9678a5c257bfee5f9be41c4144752765a77951f72b111::town {
    struct TOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOWN>(arg0, 9, b"Town", x"546f776e20f09f8c86", b"A City", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/New_York_City_%28New_York%2C_USA%29%2C_Empire_State_Building_--_2012_--_6448.jpg/1200px-New_York_City_%28New_York%2C_USA%29%2C_Empire_State_Building_--_2012_--_6448.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOWN>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOWN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

