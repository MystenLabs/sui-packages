module 0x31b60b41874f74fcde4d8290eb2dea7f81cb9b826d7f0ff907fe5e7f5378ab97::bbb {
    struct BBB has drop {
        dummy_field: bool,
    }

    struct Burner has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<BBB>,
    }

    fun init(arg0: BBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBB>(arg0, 9, b"8==D", b"8==D", b"8==D", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BBB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BBB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

