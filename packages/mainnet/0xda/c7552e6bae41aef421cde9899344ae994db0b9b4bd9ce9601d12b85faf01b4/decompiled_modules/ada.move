module 0xdac7552e6bae41aef421cde9899344ae994db0b9b4bd9ce9601d12b85faf01b4::ada {
    struct ADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADA>(arg0, 6, b"ADA", b"Solama", b"Desert sheep are extremely rare. If you are a good shepherd, hold them and they will make you rich.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000507_2a5fffff70.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADA>>(v1);
    }

    // decompiled from Move bytecode v6
}

