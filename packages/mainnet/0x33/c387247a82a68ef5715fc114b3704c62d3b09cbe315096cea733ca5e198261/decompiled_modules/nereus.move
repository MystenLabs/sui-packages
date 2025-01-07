module 0x33c387247a82a68ef5715fc114b3704c62d3b09cbe315096cea733ca5e198261::nereus {
    struct NEREUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEREUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEREUS>(arg0, 6, b"Nereus", b"Nereus on Sui", b"Nereus, the ancient sea monster, rises from the depths of the Sui blockchain. Fierce and untamed, this mythical beast brings the raw power of the ocean to Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Nereus_cfd8abd1a8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEREUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEREUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

