module 0xae4485dfd019414e71da1ae8268a82605e1761ba7db890480452d202e988fd34::smile {
    struct SMILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMILE>(arg0, 9, b"SMILE", b"smile", b"smile or die. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/9b2fbda8-d74b-4afa-983f-0c0a1f4ac51b.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMILE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMILE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

