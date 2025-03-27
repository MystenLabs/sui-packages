module 0x5edeac961428358e502c8f6c146a911e9b004dcb236afe552470b2ed880ae96f::walcard {
    struct WALCARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALCARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALCARD>(arg0, 6, b"WALCARD", b"Walrus card", b"The first walrus card to allow users to transact insfrastructure under the name $WALCARD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000076254_6c7bc2f0c5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALCARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALCARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

