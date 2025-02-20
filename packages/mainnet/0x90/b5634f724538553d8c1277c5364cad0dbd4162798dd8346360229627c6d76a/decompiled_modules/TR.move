module 0x90b5634f724538553d8c1277c5364cad0dbd4162798dd8346360229627c6d76a::TR {
    struct TR has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TR>, arg1: 0x2::coin::Coin<TR>) {
        0x2::coin::burn<TR>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TR>>(0x2::coin::mint<TR>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TR>(arg0, 0, b"Tonkotsu ramen", b"TR", b"The broth for tonkotsu ramen is based on pork bones, which is what the word tonkotsu means in Japanese.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/Q3dkgfDz/tonkotsu.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

