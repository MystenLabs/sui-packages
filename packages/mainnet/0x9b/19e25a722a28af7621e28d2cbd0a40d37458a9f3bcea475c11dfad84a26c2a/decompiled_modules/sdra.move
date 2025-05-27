module 0x9b19e25a722a28af7621e28d2cbd0a40d37458a9f3bcea475c11dfad84a26c2a::sdra {
    struct SDRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDRA>(arg0, 6, b"Sdra", b"Suidra ", x"5468652066696572636520576174657220447261676f6e20506f6bc3a96d6f6ee2809424535549445241206973206120636f6d6d756e6974792d64726976656e206d656d6520636f696e2063656c6562726174696e672053756920616e642069747320666173742c20666c75696420626c6f636b636861696e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748376016169.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDRA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDRA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

