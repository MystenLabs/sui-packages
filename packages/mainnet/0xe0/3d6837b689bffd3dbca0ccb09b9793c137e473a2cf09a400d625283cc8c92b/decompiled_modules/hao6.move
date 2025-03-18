module 0xe03d6837b689bffd3dbca0ccb09b9793c137e473a2cf09a400d625283cc8c92b::hao6 {
    struct HAO6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAO6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAO6>(arg0, 6, b"HAO6", b"HAO006", b"006", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqpnYc1ySmiFngowzZJPuddKLNGv3Hmy1mKA&s"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HAO6>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAO6>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HAO6>>(v2);
    }

    // decompiled from Move bytecode v6
}

