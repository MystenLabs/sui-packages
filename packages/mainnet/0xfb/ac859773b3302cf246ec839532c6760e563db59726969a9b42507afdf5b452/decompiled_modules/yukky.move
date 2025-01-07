module 0xfbac859773b3302cf246ec839532c6760e563db59726969a9b42507afdf5b452::yukky {
    struct YUKKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUKKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUKKY>(arg0, 6, b"YUKKY", b"YUKKY", b"YUKKY pair launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyW8nWT7eDDDRgHCcvUwmjp6qaSzGpY4Iefg&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YUKKY>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUKKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUKKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

