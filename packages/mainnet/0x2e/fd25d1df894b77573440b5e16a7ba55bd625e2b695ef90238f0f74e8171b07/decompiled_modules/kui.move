module 0x2efd25d1df894b77573440b5e16a7ba55bd625e2b695ef90238f0f74e8171b07::kui {
    struct KUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUI>(arg0, 9, b"KUI", b"SharKui", b"https://x.com/KUI_on_SUI?t=yZDT2tYzO8zRRq7ksc-P2A&s=09", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KUI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUI>>(v2, @0x1c4d2b9c24f3ed50e3594b76190017d5a02cfe93a19275e4929150a706753741);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

