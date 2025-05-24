module 0x8592380101a3cab49e1c4444141105e6a1d60bde7dcab354959cb973b9246da::os {
    struct OS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OS>(arg0, 6, b"OS", b"Ostrich", b"Ostrich is a groundbreaking memecoin on the Sui blockchain, designed to build a strong, active, and engaged community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihr4xu3sapqcwuvmx5o5zzjjpquhjtj4ihg7rnd4of7i2d6h6ae34")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

