module 0x23c005a5fc077d18c3bcd158c0b4468019889a356c2279f7209ab1f84ef1ae5f::crack {
    struct CRACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRACK>(arg0, 9, b"Crack", b"Snowfall", b"This limited-edition collectible represents the rise, power, and ultimate price of ambition in the crack era. Designed with intricate detail and premium craftsmanship, its a must-have for fans who appreciate the cultural impact.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfYN7NU5R4JeQVqmuu7sykkPUirnpG44ZknL7t7Z6Hbzw")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CRACK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRACK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRACK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

