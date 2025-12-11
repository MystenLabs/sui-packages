module 0xd37c3878a2b036622f3389f64b37e1fdbea812af27d264977cada0eb0c6105fe::magasui {
    struct MAGASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGASUI>(arg0, 9, b"MAGASUI", b"MAGASUI", b"Make Apps Great Again on SUI - 297M supply for 297k TPS", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGASUI>>(v1);
        let v3 = 0x2::coin::mint<MAGASUI>(&mut v2, 297000000000000000, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MAGASUI>>(0x2::coin::split<MAGASUI>(&mut v3, 297000000000000000 * 3 / 100, arg1), @0x8c47c3e7b44a89a08c13a8e36d3a6f6c2b309a0);
        0x2::transfer::public_transfer<0x2::coin::Coin<MAGASUI>>(0x2::coin::split<MAGASUI>(&mut v3, 297000000000000000 * 2 / 100, arg1), @0xac6dcbb172afc3da22a0af47111c6e1781bade7f1eae8fd203954e024c9e0eb);
        0x2::transfer::public_transfer<0x2::coin::Coin<MAGASUI>>(0x2::coin::split<MAGASUI>(&mut v3, 297000000000000000 * 5 / 100, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<MAGASUI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGASUI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

