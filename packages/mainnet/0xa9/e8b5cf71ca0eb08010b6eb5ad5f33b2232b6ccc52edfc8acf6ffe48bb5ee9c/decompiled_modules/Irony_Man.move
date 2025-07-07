module 0xa9e8b5cf71ca0eb08010b6eb5ad5f33b2232b6ccc52edfc8acf6ffe48bb5ee9c::Irony_Man {
    struct IRONY_MAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRONY_MAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRONY_MAN>(arg0, 9, b"IRONY", b"Irony Man", b"irony man is here to stay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/3749974c-6fab-4897-a620-bf9cde9fa67a.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IRONY_MAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRONY_MAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

