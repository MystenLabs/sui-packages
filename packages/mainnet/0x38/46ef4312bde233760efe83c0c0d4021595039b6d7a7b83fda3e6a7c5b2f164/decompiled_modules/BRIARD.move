module 0x3846ef4312bde233760efe83c0c0d4021595039b6d7a7b83fda3e6a7c5b2f164::BRIARD {
    struct BRIARD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BRIARD>, arg1: 0x2::coin::Coin<BRIARD>) {
        0x2::coin::burn<BRIARD>(arg0, arg1);
    }

    fun init(arg0: BRIARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRIARD>(arg0, 9, b"BRIARD", b"Briard Inu", b"The Most Delicious Cat on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/dkQPKV8/briard.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRIARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRIARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BRIARD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BRIARD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

