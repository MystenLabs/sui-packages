module 0x45df3c36771357802932f52f572e282cfc29bbd6d9cb5bb9ea66ab07fdab31a2::DEFAI {
    struct DEFAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DEFAI>, arg1: 0x2::coin::Coin<DEFAI>) {
        0x2::coin::burn<DEFAI>(arg0, arg1);
    }

    fun init(arg0: DEFAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEFAI>(arg0, 9, b"DEFAI", b"DEFAI", b"yolo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREH8eOkHxsELIF5Ztbh9Q5_SznwHUU3bWncQ&s")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEFAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEFAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DEFAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DEFAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

