module 0x70e245034e0eecee149a0822849fa229168e29487042ca6549a8f9a5e53fb3f::pos {
    struct POS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POS>(arg0, 6, b"POS", b"Penisaur On Sui", b"penisaur rill token meme sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/penisaur_49e2a2fd54.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POS>>(v1);
    }

    // decompiled from Move bytecode v6
}

