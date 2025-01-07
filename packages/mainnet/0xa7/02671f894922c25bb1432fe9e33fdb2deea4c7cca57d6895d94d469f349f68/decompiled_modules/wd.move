module 0xa702671f894922c25bb1432fe9e33fdb2deea4c7cca57d6895d94d469f349f68::wd {
    struct WD has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<WD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WD>>(0x2::coin::mint<WD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: WD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WD>(arg0, 1, b"WD", b"sds", b"sd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WD>>(0x2::coin::mint<WD>(&mut v2, 2300, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

