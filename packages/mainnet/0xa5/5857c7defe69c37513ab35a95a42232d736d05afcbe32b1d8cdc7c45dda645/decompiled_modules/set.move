module 0xa55857c7defe69c37513ab35a95a42232d736d05afcbe32b1d8cdc7c45dda645::set {
    struct SET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SET>(arg0, 9, b"SET", b"Siu Elephant Token", b"The big Elephant inu built on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/3NShy0n")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SET>(&mut v2, 9000111000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SET>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SET>>(v1);
    }

    // decompiled from Move bytecode v6
}

