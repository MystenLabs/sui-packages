module 0xf6b3edfc46a7c469eb2645f1615a44ef984796177df58e2d95fb970cb2a2102::sbomb {
    struct SBOMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOMB>(arg0, 6, b"SBomb", b"Sui Bomb", x"53756920426f6d62204d656d6520546f6b656e2e0a4c65742773206272696e6720736f6d6520776176657320746f2073756920616e64206c65747320736f6d657468696e67206275696c64206f6e2069742021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054116_8ed580238e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBOMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

