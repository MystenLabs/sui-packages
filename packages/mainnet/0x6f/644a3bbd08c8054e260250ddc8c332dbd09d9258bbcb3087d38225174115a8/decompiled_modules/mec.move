module 0x6f644a3bbd08c8054e260250ddc8c332dbd09d9258bbcb3087d38225174115a8::mec {
    struct MEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEC>(arg0, 9, b"MEC", b"MEC", b"Web3 Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEC>(&mut v2, 20000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEC>>(v2, @0xc0a0a2539b505666b82575788f6bb554c2e0324865f4113aed3f5eca81609c38);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEC>>(v1);
    }

    // decompiled from Move bytecode v6
}

