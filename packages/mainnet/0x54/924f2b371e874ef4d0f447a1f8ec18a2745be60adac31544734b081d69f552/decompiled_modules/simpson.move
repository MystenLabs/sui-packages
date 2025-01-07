module 0x54924f2b371e874ef4d0f447a1f8ec18a2745be60adac31544734b081d69f552::simpson {
    struct SIMPSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMPSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMPSON>(arg0, 6, b"Simpson", b"Sui Simpson", b"MeMe Simpson Simpson Simpson Simpson", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SIMSON_5937205b30.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMPSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMPSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

