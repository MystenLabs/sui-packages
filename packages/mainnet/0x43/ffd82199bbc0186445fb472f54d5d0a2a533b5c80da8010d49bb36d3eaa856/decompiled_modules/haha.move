module 0x43ffd82199bbc0186445fb472f54d5d0a2a533b5c80da8010d49bb36d3eaa856::haha {
    struct HAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAHA>(arg0, 6, b"HAHA", b"haha", b"hahahahaha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/qgI49-Uc2rC2bsG8l_GhlWqx1XEekQDqxxT-EGWO3Vc")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HAHA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAHA>>(v2, @0x703cd1c1f68d239745a177b522a2f8651e8f8cd86e91ad9322cbec99b204ce38);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

