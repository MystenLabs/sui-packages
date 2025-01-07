module 0x332703eed80c5e529df8d11a88d558738a6ce091615e9aae7435977c0e41cfaa::ssr {
    struct SSR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSR>(arg0, 6, b"SSR", b"Strategic SUI Reserve", b"Welcome to the SSR, where the Federal Reserve is destined to add SUI to the balance sheet of the USA!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2dai_creation_3743057b512a3a35de4d3be8e2658a1f_b468f3b273.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSR>>(v1);
    }

    // decompiled from Move bytecode v6
}

