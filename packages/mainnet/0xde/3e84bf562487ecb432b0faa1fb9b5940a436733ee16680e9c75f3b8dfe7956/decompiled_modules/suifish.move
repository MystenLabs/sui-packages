module 0xde3e84bf562487ecb432b0faa1fb9b5940a436733ee16680e9c75f3b8dfe7956::suifish {
    struct SUIFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFISH>(arg0, 6, b"SUIFISH", b"Magical Fish of the Great Sui Seas!", b"$SUIFISH is a mystical token swimming through the Sui, guided by a magical fish. Flow with the currents of this enchanting journey and discover the hidden treasures beneath the surface. Ready to ride the waves of wonder with $SUIFISH?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIFISH_c1862a1f2f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

