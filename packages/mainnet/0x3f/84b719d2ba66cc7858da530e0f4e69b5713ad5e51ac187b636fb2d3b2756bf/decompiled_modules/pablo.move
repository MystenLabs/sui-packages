module 0x3f84b719d2ba66cc7858da530e0f4e69b5713ad5e51ac187b636fb2d3b2756bf::pablo {
    struct PABLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PABLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PABLO>(arg0, 9, b"Pablo", b"Pablo", b"Pablo Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PABLO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PABLO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PABLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

