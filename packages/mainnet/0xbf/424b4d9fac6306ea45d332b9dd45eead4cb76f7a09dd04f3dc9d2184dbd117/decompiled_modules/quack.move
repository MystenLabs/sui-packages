module 0xbf424b4d9fac6306ea45d332b9dd45eead4cb76f7a09dd04f3dc9d2184dbd117::quack {
    struct QUACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUACK>(arg0, 6, b"QUACK", b"Debug Duck", b"Born in a factory of defective toys, our rubber duck had a factory bug: it was self-aware. While other debug ducks helped programmers solve problems, $QUACK decided its purpose in life was to create problems!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hero_duck_ba3a476cd5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

