module 0xe984f2a9569fe7e66aecc654e61c05a2f84d8168c1c1233e2ade49c29363704b::kemusan {
    struct KEMUSAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEMUSAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEMUSAN>(arg0, 6, b"KEMUSAN", b"Kemusan Sui", b"$KEMUSAN on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_26_15_41_31_7937d14505.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEMUSAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEMUSAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

