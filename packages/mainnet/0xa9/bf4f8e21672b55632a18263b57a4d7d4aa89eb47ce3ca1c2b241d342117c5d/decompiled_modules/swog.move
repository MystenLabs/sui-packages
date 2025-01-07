module 0xa9bf4f8e21672b55632a18263b57a4d7d4aa89eb47ce3ca1c2b241d342117c5d::swog {
    struct SWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOG>(arg0, 6, b"Swog", b"Swog Sui", b"In the water emerged a new swog, a more based  swog for sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/swog_on_sui_fda5d729f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

