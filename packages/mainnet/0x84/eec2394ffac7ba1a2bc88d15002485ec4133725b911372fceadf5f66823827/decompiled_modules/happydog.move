module 0x84eec2394ffac7ba1a2bc88d15002485ec4133725b911372fceadf5f66823827::happydog {
    struct HAPPYDOG has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HAPPYDOG>, arg1: 0x2::coin::Coin<HAPPYDOG>) {
        0x2::coin::burn<HAPPYDOG>(arg0, arg1);
    }

    fun init(arg0: HAPPYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<HAPPYDOG>(arg0, 6, b"HAPPYDOG", b"Happy Dog", b"Happy Happy Happy~ Happy Happy Happy Happy~ This is the happy song~", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://b1157417.smushcdn.com/1157417/wp-content/uploads/2023/09/happy-dog-with-big-tongue-out.jpg"))), false, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPPYDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HAPPYDOG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAPPYDOG>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HAPPYDOG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HAPPYDOG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

