module 0x8a3286d787498b6c709aac154de16572afe3220bf8ddf282168b932a71e83cf1::milly {
    struct MILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILLY>(arg0, 6, b"Milly", b"Milly on Sui", b"The one and only Milly on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_1_4e71b500d0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

