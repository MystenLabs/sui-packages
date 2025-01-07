module 0x6b573cb7175a0758db5f1fc4285951a3e270ff557468597ca5ee95058a74c224::bubble {
    struct BUBBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLE>(arg0, 6, b"BUBBLE", b"Bubble", b"Bubble has arrived to take over the seven seas of Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0784_a55181afca.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

