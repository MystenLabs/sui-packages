module 0xbc3f3c7d1200809b94d639040429fdfc882ee9de46b7dcb2bc96e92003100de1::tsc {
    struct TSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSC>(arg0, 9, b"TSC", b"The Shittiest Coin", b"It's one of the shittiest coins lol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://elephant.art/wp-content/uploads/2019/11/poop-emoji.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TSC>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSC>>(v2, @0x114a63e533262fee088dcfe8c015d6786ec681611abe3c72c77abdf278a8f0f5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

