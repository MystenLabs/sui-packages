module 0x1bd1e95da2edb09e0814dfc9beb65a5059ed779b4974f1a3f7eafd52eea1db21::tirex {
    struct TIREX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIREX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIREX>(arg0, 6, b"TIREX", b"Official Tirex on Sui", b"Official Tirex on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tirex_1_7120a6c5a9.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIREX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIREX>>(v1);
    }

    // decompiled from Move bytecode v6
}

