module 0xb6cba87330115fc94958e3df9ece434aef83b0315b51e9d2f820a04e3a8cf560::tttt {
    struct TTTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTTT>(arg0, 9, b"tttt", b"tttt", b"tttttt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/A6UntnQyA3zAYRjDNC5C9AlwRx5pK08HM5z-p5wEuhU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TTTT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTTT>>(v2, @0x622ed5dd7448fadb080d8c1d0d0d18d64158475ed34c3701fe31cf5ad112a3eb);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TTTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

