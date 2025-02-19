module 0x60b438a3eba5a9faad667aed24e1f861399d4f03392e696ea526eb15788865d4::kateleo {
    struct KATELEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KATELEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KATELEO>(arg0, 9, b"KATELEO", b"Kate and Leopold", b"Romance movie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/BOewHQp.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KATELEO>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KATELEO>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KATELEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

