module 0x9d51d3d38b8afe115700f792f3a38fd7dd9bc01a56db5215031c7dcabe20f39e::tuce {
    struct TUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUCE>(arg0, 6, b"TUCE", b"Lettuce", b"Being a good memecoin full of laughter and fun is what TUCE goals", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009730_73dad01acc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

