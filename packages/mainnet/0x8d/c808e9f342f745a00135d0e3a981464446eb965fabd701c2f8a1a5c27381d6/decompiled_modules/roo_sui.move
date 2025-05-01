module 0x8dc808e9f342f745a00135d0e3a981464446eb965fabd701c2f8a1a5c27381d6::roo_sui {
    struct ROO_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROO_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROO_SUI>(arg0, 9, b"rooSUI", b"Rootlets Staked SUI", b"Rootlets Staked Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/787952eb-1261-4642-ba23-d26c704e47dd/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROO_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROO_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

