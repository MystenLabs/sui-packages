module 0x865f62a3a4e38bb56f99944c372f5bbca709a12fb087d8324f0e767d49dc4c31::e_sui {
    struct E_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: E_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<E_SUI>(arg0, 9, b"eSUI", b"Emriss Staked SUI", b"Staking by Emriss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/e9768eac-7e7f-4126-aa36-9c1dbce8e7f0/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<E_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<E_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

