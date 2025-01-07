module 0x12a6f6f014ca505bc879b10e992e8599797a2e33f21ae4c077a448c02dc7d202::t4321 {
    struct T4321 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T4321, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T4321>(arg0, 6, b"T4321", b"Test4321", b"testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Picture1_f6848cc0de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T4321>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T4321>>(v1);
    }

    // decompiled from Move bytecode v6
}

