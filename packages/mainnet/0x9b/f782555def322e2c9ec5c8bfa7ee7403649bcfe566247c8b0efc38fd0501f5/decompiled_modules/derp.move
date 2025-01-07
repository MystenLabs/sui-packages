module 0x9bf782555def322e2c9ec5c8bfa7ee7403649bcfe566247c8b0efc38fd0501f5::derp {
    struct DERP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DERP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DERP>(arg0, 6, b"Derp", b"Derp", b"Derp pair launch on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGS355pTxy89ZEfSoNA8DsxPL5C3yGXkDi3A&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DERP>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DERP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DERP>>(v1);
    }

    // decompiled from Move bytecode v6
}

