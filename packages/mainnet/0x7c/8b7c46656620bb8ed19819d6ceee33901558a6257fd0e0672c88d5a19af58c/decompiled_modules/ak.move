module 0x7c8b7c46656620bb8ed19819d6ceee33901558a6257fd0e0672c88d5a19af58c::ak {
    struct AK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AK>(arg0, 6, b"AK", b"Akai", b"AKAI is an AI Agent that helps you explore deep into the global AI technology scene!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/1a811c5f-e316-4d32-a70c-98031c06583b.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

