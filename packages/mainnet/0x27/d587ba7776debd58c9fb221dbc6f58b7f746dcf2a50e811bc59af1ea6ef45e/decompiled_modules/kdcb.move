module 0x27d587ba7776debd58c9fb221dbc6f58b7f746dcf2a50e811bc59af1ea6ef45e::kdcb {
    struct KDCB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KDCB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KDCB>(arg0, 7, b"KDCB", b"KDCB", b"KDCB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreiaasf3a2cfbfhuevp2ffmfevizmuu3qddmwqaiq2cdogfxisce26u")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<KDCB>>(0x2::coin::mint<KDCB>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KDCB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KDCB>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

