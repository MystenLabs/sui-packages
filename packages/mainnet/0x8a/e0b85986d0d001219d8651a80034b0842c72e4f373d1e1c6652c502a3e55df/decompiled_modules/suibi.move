module 0x8ae0b85986d0d001219d8651a80034b0842c72e4f373d1e1c6652c502a3e55df::suibi {
    struct SUIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBI>(arg0, 6, b"SUIBI", b"Suibi Sui", b"Dive into the deep waters of $SUIBI, every bubble is a gold coin on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029116_180509404e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

