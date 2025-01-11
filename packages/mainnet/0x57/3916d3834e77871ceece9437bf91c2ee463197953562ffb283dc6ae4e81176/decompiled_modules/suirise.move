module 0x573916d3834e77871ceece9437bf91c2ee463197953562ffb283dc6ae4e81176::suirise {
    struct SUIRISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRISE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIRISE>(arg0, 6, b"SUIRISE", b"SUIRISE  by SuiAI", b"SUIRISE ($SRISE) is a community-driven force, not mere observers but the architects of a movement. Fueled by faith in Sui network's rise, we mobilize the masses, propelling Sui to the innovation forefront. It's about forging a blockchain culture, with the goal to boost Sui's potential, spark a collective uprising, and drive its global impact. This is a movement that defies the status quo for a self-shaped future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2024_10_23_08_45_26_9eda1e13c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIRISE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRISE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

