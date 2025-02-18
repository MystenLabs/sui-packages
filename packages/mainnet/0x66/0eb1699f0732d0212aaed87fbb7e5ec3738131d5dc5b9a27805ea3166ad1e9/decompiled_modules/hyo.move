module 0x660eb1699f0732d0212aaed87fbb7e5ec3738131d5dc5b9a27805ea3166ad1e9::hyo {
    struct HYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYO>(arg0, 9, b"HYO", b"Hyoma Chigiri", b"Chigiri is a confident and driven individual who loves surpassing others on the field. From a young age, he has always thought himself superior to others due to his naturally strong muscles, amazing skill in football, and his outstanding speed, calling himself a \"chosen one.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/bpkSdjt.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HYO>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYO>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYO>>(v1);
    }

    // decompiled from Move bytecode v6
}

