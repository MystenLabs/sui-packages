module 0xc919ec34c71d1a6e1e64759b9ffcb6cccca1d71df9943ae629479dcf5cf052d1::lihuazhang_coin {
    struct LIHUAZHANG_COIN has drop {
        dummy_field: bool,
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LIHUAZHANG_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LIHUAZHANG_COIN>>(0x2::coin::mint<LIHUAZHANG_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LIHUAZHANG_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIHUAZHANG_COIN>(arg0, 9, b"LC", b"Lihuazhang Coin", b"Lihuazhang Coin Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://testerhome.com/photo/2015/f4a07b35098dc28fa3e4269c8af2fc7b.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIHUAZHANG_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIHUAZHANG_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

