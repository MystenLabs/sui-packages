module 0x72ce3c534460545cd6b5cbb925dd9864cfe7f112c3e57164d46bed5e1b668814::animalio {
    struct ANIMALIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANIMALIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANIMALIO>(arg0, 6, b"ANIMALIO", b"ANIMALIO on SUI", x"6d75746174656420736f6c64696572732067656172656420757020746f2070726f746563742074686520666f72657374732066726f6d2074686520696e766164696e67206576696c20686f726465200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a79u_7xr_400x400_f33e206737.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANIMALIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANIMALIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

