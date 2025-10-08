module 0xee881c5268b7414a24332bfa1ff16182023c08b6e0c65574217f3603430313c8::nphx1430 {
    struct NPHX1430 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPHX1430, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NPHX1430>(arg0, 9, b"NPHX1430", b"Nebula Phoenix #1430", b"Rising from the ashes of traditional finance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/nebula-phoenix.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NPHX1430>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPHX1430>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

