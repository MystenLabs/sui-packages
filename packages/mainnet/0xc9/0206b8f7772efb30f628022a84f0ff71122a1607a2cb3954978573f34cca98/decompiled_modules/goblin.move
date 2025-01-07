module 0xc90206b8f7772efb30f628022a84f0ff71122a1607a2cb3954978573f34cca98::goblin {
    struct GOBLIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GOBLIN>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GOBLIN>>(0x2::coin::mint<GOBLIN>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: GOBLIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOBLIN>(arg0, 9, b"GOBLIN", b"GOBLIN", b"Welcome to The Goblin show...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1821685063634825216/sKIbzU1F_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOBLIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOBLIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOBLIN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

