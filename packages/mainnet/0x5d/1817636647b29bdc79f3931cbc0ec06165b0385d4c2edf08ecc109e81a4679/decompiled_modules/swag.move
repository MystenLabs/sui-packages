module 0x5d1817636647b29bdc79f3931cbc0ec06165b0385d4c2edf08ecc109e81a4679::swag {
    struct SWAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWAG>(arg0, 6, b"Swag", b"SwagBag", b"Grab a Bag Of Swag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/79e6a04b6205be3571647174f297206c_746a2795d1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

