module 0x29363b0fce4826443b64ec7d73b3e45cad3ff4dcca7da3c0e73ac78fa088252d::root {
    struct ROOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROOT>(arg0, 6, b"ROOT", b"Rootlets", b"Cute creatures have come from the Suiverse to colonize Earth! Get ready, lets rt!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3tdxr_I4o_400x400_e0173a5d24.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

