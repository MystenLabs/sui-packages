module 0x7a583f1aad92244993fb3a84feebe2136724cf50eb3f2e242c904d2baa059e79::fishai {
    struct FISHAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHAI>(arg0, 6, b"FISHAI", b"SUI AI FISH", b"$FISHAI is a unique meme coin inspired by ocean adventures and cosmic ambitions! Join our fun community as we aim to explore new horizons in the crypto world. Every time you hold $FISH, you take a step toward a new financial journey filled with joy and excitement. Catch the wave and fly to the moon with us!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_16_08_11_08_a7b61e5530.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

