module 0x53a2c6f761626d83ba5cfdf5a634654e2e082d0e1286e05412412ae931ee3537::otty {
    struct OTTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTY>(arg0, 6, b"OTTY", b"OTTY ON SUI", b"$OTTY the lightning-fast otter of the Sui waters! With sleek moves and boundless energy, $OTTY is here to bring the thrill of the chase to the Sui. Dive in and ride the waves with this agile, unstoppable otter as it swims straight toward success!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OTTIER_3e46e06e91.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

