module 0x548d84ed1b188d76a9eb0900f01f2d3aee99d4ad7b20da9b4227298fed1cae86::flow {
    struct FLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOW>(arg0, 9, b"FLOW", b"FLOW", b"FLOW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/raidenx-prod/logo/sui/0x6e130d2e13ede3bc42fa2101d21a3d910f5bbdd0426a2ae242aed235eab8dc98::flow::FLOW.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLOW>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOW>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

