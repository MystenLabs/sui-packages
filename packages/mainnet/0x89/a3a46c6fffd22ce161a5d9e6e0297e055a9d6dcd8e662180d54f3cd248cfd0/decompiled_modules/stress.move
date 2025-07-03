module 0x89a3a46c6fffd22ce161a5d9e6e0297e055a9d6dcd8e662180d54f3cd248cfd0::stress {
    struct STRESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRESS>(arg0, 9, b"STRESS", b"stress", b"lfg ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/bcc40c23-e21f-4927-864e-31b26c9144c9.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STRESS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRESS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

