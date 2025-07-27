module 0x57442b8fe4ae43c2c50c215e6c6306aa848b6938cdb520553e9d68927b6caef8::mil {
    struct MIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIL>(arg0, 6, b"MIL", b"Milu", b"In the vast courtyard of a grand mansion, stands Milu the white Sphynx cat draped in his iconic blue Sui hoodie. Calm yet confident, he is more than just a pet his a modern icon. Despite the luxury around him, Milu stays grounded. always ready to greet the world with a wave.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiequoeascmckci5bn7nc6q54fqbeke535xmvvb6uy3s6pbl4rd2fu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MIL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

