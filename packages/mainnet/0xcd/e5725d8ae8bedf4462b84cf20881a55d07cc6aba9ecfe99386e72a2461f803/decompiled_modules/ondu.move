module 0xcde5725d8ae8bedf4462b84cf20881a55d07cc6aba9ecfe99386e72a2461f803::ondu {
    struct ONDU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONDU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONDU>(arg0, 9, b"ONDU", b"Ondulaga", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://th.bing.com/th/id/OIG1.D_lStI0zQHSyfoEw8tfm?w=270&h=270&c=6&r=0&o=5&pid=ImgGn")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ONDU>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONDU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONDU>>(v1);
    }

    // decompiled from Move bytecode v6
}

