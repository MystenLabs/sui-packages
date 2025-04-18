module 0x9cdd729772aed608920e66ab0647195de2cb9b898ef76e00b90cd9f670a5e31f::thd {
    struct THD has drop {
        dummy_field: bool,
    }

    fun init(arg0: THD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THD>(arg0, 9, b"THD", b"Tidehunters DAO", b"Tidehunters DAO is a decentralized organization on the Sui network, inspired by the tides of the ocean. Just as the tides shape the shore, the DAO enables its members to navigate and influence the ever-changing crypto market through collaborative governance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/c70442f0-da0d-11ef-80e8-811f7f414973")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THD>>(v1);
        0x2::coin::mint_and_transfer<THD>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THD>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

