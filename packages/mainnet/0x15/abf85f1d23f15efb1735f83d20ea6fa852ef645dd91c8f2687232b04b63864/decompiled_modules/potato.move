module 0x15abf85f1d23f15efb1735f83d20ea6fa852ef645dd91c8f2687232b04b63864::potato {
    struct POTATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTATO>(arg0, 9, b"POTATO", b"Potato", b"PoTaTo Sui Community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1599904422556946432/mDMnW0wT_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POTATO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTATO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POTATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

