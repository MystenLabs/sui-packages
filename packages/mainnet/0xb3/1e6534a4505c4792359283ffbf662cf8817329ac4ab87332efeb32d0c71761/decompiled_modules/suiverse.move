module 0xb31e6534a4505c4792359283ffbf662cf8817329ac4ab87332efeb32d0c71761::suiverse {
    struct SUIVERSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVERSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVERSE>(arg0, 9, b"SUIVERSE", b"SUIVERSE", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIVERSE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVERSE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIVERSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

