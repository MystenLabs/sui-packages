module 0x4d2960267b18f604f91462dd618c88de94ba0672b0e404de10513c197174a023::suieal {
    struct SUIEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEAL>(arg0, 6, b"SUIEAL", b"Sui Seal", b"Meet Sui Seal, Gliding through the deep waters of the Sui network, this seal is sleek, swift, and ready to make waves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bbbb_94fb9579e6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

