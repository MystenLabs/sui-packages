module 0x550097ce6290aa54423a0332fc29479d4ed57dcaddb44ef9d491152942c78d19::aps {
    struct APS has drop {
        dummy_field: bool,
    }

    fun init(arg0: APS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APS>(arg0, 9, b"APS", b"APPLE ON SUI", b"APPLE ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"APPLE ON SUI")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<APS>(&mut v2, 55555555000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APS>>(v1);
    }

    // decompiled from Move bytecode v6
}

