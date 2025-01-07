module 0x700b6e02135953f1270566db06cb39ef27d0478f931443d3606e20a2e471b935::kid {
    struct KID has drop {
        dummy_field: bool,
    }

    fun init(arg0: KID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KID>(arg0, 6, b"KID", b"Suiccess Kid", b"Success with the Suiccess Kid.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_i_e_i_2024_09_26_162212_420677587d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KID>>(v1);
    }

    // decompiled from Move bytecode v6
}

