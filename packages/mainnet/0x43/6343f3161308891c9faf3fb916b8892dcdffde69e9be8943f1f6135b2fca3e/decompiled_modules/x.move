module 0x436343f3161308891c9faf3fb916b8892dcdffde69e9be8943f1f6135b2fca3e::x {
    struct X has drop {
        dummy_field: bool,
    }

    fun init(arg0: X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<X>(arg0, 6, b"X", b"X token", b"X tokenn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/18078e59-6ef1-4395-bffe-72a9082a1860.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<X>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<X>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<X>>(v1);
    }

    // decompiled from Move bytecode v6
}

