module 0xd52226294858c677096ecd4d51f4e00e4452bffdb1d131d030ffa6e812244572::crabs {
    struct CRABS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRABS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRABS>(arg0, 6, b"CRABS", b"Crabs On Sui", b"Hi, I'm Mr. Krabs, people say I'm venal and stingy. It's not true, I just love money and I have only one idea in mind: to make money !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000440_aa597fd23c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRABS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRABS>>(v1);
    }

    // decompiled from Move bytecode v6
}

