module 0x98f46439be105db7b45f1ae3a4408ee6b8287905c0f66b38164bbbf21cfe088b::suirunner {
    struct SUIRUNNER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRUNNER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRUNNER>(arg0, 6, b"SUIRUNNER", b"Sui Runner", b"We are launching the first real online game on the Sui Network. You can play online games with Sui Runner and win Sui Runner. The V1 version of the game is now live, many more will come soon. You can enter Sui Runner award-winning battles with your friends, we are coming soon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000033563_9292babd75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRUNNER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRUNNER>>(v1);
    }

    // decompiled from Move bytecode v6
}

