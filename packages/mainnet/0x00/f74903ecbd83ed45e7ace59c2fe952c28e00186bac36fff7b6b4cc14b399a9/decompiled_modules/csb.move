module 0xf74903ecbd83ed45e7ace59c2fe952c28e00186bac36fff7b6b4cc14b399a9::csb {
    struct CSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSB>(arg0, 8, b"CSB", b"Sui Casino Club", b"Sui Casino Club", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/J1eFn99.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CSB>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSB>>(v1);
    }

    // decompiled from Move bytecode v6
}

