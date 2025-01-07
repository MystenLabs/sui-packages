module 0x38a9fbc7dcb70fb314416a059a442d8f6de2e6e0b3d5a75d832be279e7672514::soak {
    struct SOAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOAK>(arg0, 6, b"Soak", b"Soak on Sui", b"$SOAK is the ultimate burnout sponge memecoinrelatable, hilarious, and ready to absorb memes, dreams, and streams of gains. No stress, just soak it up. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_12_17_at_02_41_18_99ecbf0b59.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

