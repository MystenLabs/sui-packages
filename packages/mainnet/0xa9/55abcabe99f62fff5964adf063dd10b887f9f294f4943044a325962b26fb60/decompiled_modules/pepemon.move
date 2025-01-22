module 0xa955abcabe99f62fff5964adf063dd10b887f9f294f4943044a325962b26fb60::pepemon {
    struct PEPEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEMON>(arg0, 6, b"PEPEMON", b"PePeMon SUI", b"The ultimate crossover in the crypto space! Pepe, the meme legend, joins forces with Pokmon in an electrifying adventure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250122_165520_730_48243f4531.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

