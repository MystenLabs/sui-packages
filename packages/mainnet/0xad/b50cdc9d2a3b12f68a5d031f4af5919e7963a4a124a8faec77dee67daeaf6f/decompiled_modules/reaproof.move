module 0xadb50cdc9d2a3b12f68a5d031f4af5919e7963a4a124a8faec77dee67daeaf6f::reaproof {
    struct REAPROOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: REAPROOF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"nREA Proof Test";
        0x1::vector::remove<u8>(&mut v0, 0);
        let v1 = b"dControlled verification token for REA.social. Created to test the live sui.fun launch flow and record evidence. No promised utility or investment value.";
        0x1::vector::remove<u8>(&mut v1, 0);
        let (v2, v3) = 0x2::coin::create_currency<REAPROOF>(arg0, 6, b"REAPROOF", v0, v1, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suidot.fun/i/09gbbwRaXnLtWbMi")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REAPROOF>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REAPROOF>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

