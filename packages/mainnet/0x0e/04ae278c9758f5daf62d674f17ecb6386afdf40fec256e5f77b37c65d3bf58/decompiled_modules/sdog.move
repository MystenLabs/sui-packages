module 0xe04ae278c9758f5daf62d674f17ecb6386afdf40fec256e5f77b37c65d3bf58::sdog {
    struct SDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOG>(arg0, 6, b"SDOG", b"Spaces Dog", b"Spaces Dog is born on Sui with a vision. We're not leaving spaces until Elon Musk joins. Think you're up to the challenge?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SPACES_DOG_1_701500758b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

