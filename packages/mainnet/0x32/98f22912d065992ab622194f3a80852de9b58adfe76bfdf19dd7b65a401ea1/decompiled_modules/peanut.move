module 0x3298f22912d065992ab622194f3a80852de9b58adfe76bfdf19dd7b65a401ea1::peanut {
    struct PEANUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEANUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEANUT>(arg0, 6, b"PEANUT", b"First Sheriff Peanut On Sui", b"First Sheriff Peanut On Sui:suisheriffpeanut.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_48_bf39f9e84a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEANUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEANUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

