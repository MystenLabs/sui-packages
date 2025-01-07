module 0x1e5bc683deb1f0365fb045745b6af9fcae13da646cdd27f6039bc8424f001140::skt {
    struct SKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKT>(arg0, 0, b"SKT", b"Sui Skyrocket", b"Sui to the moom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgpile.com/images/tNnhC2.md.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SKT>(&mut v2, 10000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKT>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

