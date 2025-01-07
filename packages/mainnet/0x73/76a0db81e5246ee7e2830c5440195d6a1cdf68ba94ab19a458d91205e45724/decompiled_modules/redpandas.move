module 0x7376a0db81e5246ee7e2830c5440195d6a1cdf68ba94ab19a458d91205e45724::redpandas {
    struct REDPANDAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDPANDAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDPANDAS>(arg0, 6, b"REDPANDAS", b"REDPANDASSUI", x"7265642070616e6461732061726520756e64657272617465640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018306_155041dd6e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDPANDAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REDPANDAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

