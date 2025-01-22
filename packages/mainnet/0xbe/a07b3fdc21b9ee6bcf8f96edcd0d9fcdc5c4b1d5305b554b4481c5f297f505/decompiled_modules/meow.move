module 0xbea07b3fdc21b9ee6bcf8f96edcd0d9fcdc5c4b1d5305b554b4481c5f297f505::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOW>(arg0, 6, b"MEOW", b"Meow DAO", b"Meow DAO is a DAO Fund focused on GameFi and NFTFi projects. joining Katina's GameFi revolution, adding zeros", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/meowdao-token.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOW>>(v1);
        0x2::coin::mint_and_transfer<MEOW>(&mut v2, 1100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOW>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

