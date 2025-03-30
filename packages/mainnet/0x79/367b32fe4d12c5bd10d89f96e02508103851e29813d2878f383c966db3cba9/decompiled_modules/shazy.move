module 0x79367b32fe4d12c5bd10d89f96e02508103851e29813d2878f383c966db3cba9::shazy {
    struct SHAZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAZY>(arg0, 6, b"SHAZY", b"Shazy", b"Shark on sui is Shazy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052233_f52ccb39be.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

