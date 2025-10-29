module 0x8559fb2071b2cc0bc6a78064b73d06788802ca6310c0321792ba0de0c849ac45::milk {
    struct MILK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILK>(arg0, 6, b"Milk", b"Milktea", x"476f74204d696c6b3f20f09fa59b20546865206672657368657374206d656d6520636f696e206f6e2053756920626c6f636b636861696e21205765277265206e6f7420637279696e67206f766572207370696c6c6564206d696c6b202d207765277265206d616b696e67206974207261696e206461697279206761696e7321204a6f696e20746865204d696c6b2047616e6720616e64206c65742773206d6f6f2d766520746f20746865206d6f6f6e2120f09f9a80f09f90ae", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1761727837046.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MILK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

