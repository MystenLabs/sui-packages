module 0xc12bafbf19c161fd46a7ebd92bcd58da20ae88b77884a68b2282270ce6e895ea::dogwarrior {
    struct DOGWARRIOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGWARRIOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGWARRIOR>(arg0, 6, b"DogWarrior", b"Dog Warrior", b"Please join me in the battle at SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dae6fa9e7de2f3ccba9b114dada74780b2eee2065aed19eb3d77b7ceb79f380b_fc15e93651.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGWARRIOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGWARRIOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

