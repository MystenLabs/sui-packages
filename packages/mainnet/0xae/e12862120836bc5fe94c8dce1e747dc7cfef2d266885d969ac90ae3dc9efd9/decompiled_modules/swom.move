module 0xaee12862120836bc5fe94c8dce1e747dc7cfef2d266885d969ac90ae3dc9efd9::swom {
    struct SWOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOM>(arg0, 6, b"SWOM", b"swom swom", b"Swimming cats cult on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cta_cat_26af66dc0e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

