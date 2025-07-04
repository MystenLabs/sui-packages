module 0x2e2f15d45f3ccff74bb8f25fb375e616b097dde9e4c388b9c1ad4430e18134bd::kinda {
    struct KINDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINDA>(arg0, 9, b"CONCERNED", b"kinda", b"i'm worried. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/88ce4e80-69a2-44a6-9506-ca9cd78f7534.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KINDA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINDA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

