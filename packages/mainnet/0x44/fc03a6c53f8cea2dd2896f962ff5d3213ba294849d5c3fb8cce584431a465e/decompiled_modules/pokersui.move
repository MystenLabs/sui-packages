module 0x44fc03a6c53f8cea2dd2896f962ff5d3213ba294849d5c3fb8cce584431a465e::pokersui {
    struct POKERSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKERSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKERSUI>(arg0, 9, b"POKERSUI", b"Poker Sui", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTI51tS7mJCHRqUN1YX-cIyvVyPUESCEIB9g&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POKERSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKERSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POKERSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

