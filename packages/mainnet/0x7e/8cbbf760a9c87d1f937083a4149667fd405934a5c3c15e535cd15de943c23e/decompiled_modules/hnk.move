module 0x7e8cbbf760a9c87d1f937083a4149667fd405934a5c3c15e535cd15de943c23e::hnk {
    struct HNK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HNK>, arg1: 0x2::coin::Coin<HNK>) {
        0x2::coin::burn<HNK>(arg0, arg1);
    }

    fun init(arg0: HNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HNK>(arg0, 9, b"HANAKO", b"Official Sui of Hanako Coin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HNK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HNK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HNK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HNK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

