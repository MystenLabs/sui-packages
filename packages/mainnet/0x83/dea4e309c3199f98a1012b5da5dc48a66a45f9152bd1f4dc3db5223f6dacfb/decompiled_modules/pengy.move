module 0x83dea4e309c3199f98a1012b5da5dc48a66a45f9152bd1f4dc3db5223f6dacfb::pengy {
    struct PENGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGY>(arg0, 6, b"PENGY", b"SUI PENGY", b"The most lovable penguin on  SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_c943713b65.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

