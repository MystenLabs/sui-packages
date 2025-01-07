module 0xa94c91718f4a2066b4d4ae435baa7a7c2b9135469ef9e3030d757bea3c7a6595::sts {
    struct STS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STS>(arg0, 6, b"STS", b"Shaun The Sheep", b"Become part of our friendly flock! Tired of mowing the lawn? It's time to get some cabbage! Be like Shaun the Sheep have fun and get lots of cabbage!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shauntoken_eab3968d93.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STS>>(v1);
    }

    // decompiled from Move bytecode v6
}

