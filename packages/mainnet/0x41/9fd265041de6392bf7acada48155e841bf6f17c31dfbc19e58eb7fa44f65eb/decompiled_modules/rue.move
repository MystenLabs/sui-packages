module 0x419fd265041de6392bf7acada48155e841bf6f17c31dfbc19e58eb7fa44f65eb::rue {
    struct RUE has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<RUE>, arg1: 0x2::coin::Coin<RUE>) {
        0x2::coin::burn<RUE>(arg0, arg1);
    }

    fun init(arg0: RUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUE>(arg0, 6, b"rue", b"rue", b"rue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1738284060240416768/SAGrGPAM_normal.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RUE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RUE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

