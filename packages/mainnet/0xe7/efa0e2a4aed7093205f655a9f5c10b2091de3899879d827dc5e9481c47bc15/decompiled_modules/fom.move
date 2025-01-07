module 0xe7efa0e2a4aed7093205f655a9f5c10b2091de3899879d827dc5e9481c47bc15::fom {
    struct FOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOM>(arg0, 9, b"FOM", b"Fomo2023", b"Just buy and hold", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FOM>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

