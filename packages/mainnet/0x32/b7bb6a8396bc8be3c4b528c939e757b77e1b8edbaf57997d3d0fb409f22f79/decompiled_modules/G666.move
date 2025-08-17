module 0x32b7bb6a8396bc8be3c4b528c939e757b77e1b8edbaf57997d3d0fb409f22f79::G666 {
    struct G666 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<G666>, arg1: 0x2::coin::Coin<G666>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<G666>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<G666>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<G666>>(0x2::coin::mint<G666>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<G666>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<G666>>(arg0);
    }

    fun init(arg0: G666, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<G666>(arg0, 9, b"G666", b"GRAD TEST 666", b"Testing coin creator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.dictionary.com/e/wp-content/uploads/2018/03/asdfmovie-300x300.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<G666>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<G666>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

