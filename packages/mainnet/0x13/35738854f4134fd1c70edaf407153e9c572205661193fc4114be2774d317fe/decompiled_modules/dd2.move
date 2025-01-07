module 0x1335738854f4134fd1c70edaf407153e9c572205661193fc4114be2774d317fe::dd2 {
    struct DD2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DD2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DD2>(arg0, 6, b"dd2", b"dd2", b"11", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"2"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DD2>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DD2>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DD2>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

