module 0xb33950e0e87560a98aba824619a713b5f070c32573510920002ad5d0028e1655::ppx {
    struct PPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPX>(arg0, 9, b"PPX", b"Perpsplexity", b"Perpsplexity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://perpsplexity.app/api/artwork/e35d0b877879fe6ee73831ca4f57887d10fc3831389ef8f3953d9186778a6a29")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PPX>>(0x2::coin::mint<PPX>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPX>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

