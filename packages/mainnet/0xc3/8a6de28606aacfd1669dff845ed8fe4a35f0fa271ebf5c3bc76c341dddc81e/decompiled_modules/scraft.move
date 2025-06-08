module 0xc38a6de28606aacfd1669dff845ed8fe4a35f0fa271ebf5c3bc76c341dddc81e::scraft {
    struct SCRAFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCRAFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCRAFT>(arg0, 6, b"SCRAFT", b"SUICRAFT", b"Minecraft powered token created to gamity the depths of Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicyba35v5gsp6w3r5kphxfkiv6arhxx3becaeukpz3o5oalrrmxw4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCRAFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCRAFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

