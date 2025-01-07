module 0xcac7277fb80f42c581cf6e553af109f559c54b7a74e71b0f6d3403cd4e81cda6::sperm {
    struct SPERM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPERM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPERM>(arg0, 6, b"SPERM", b"Spermy", b"Spermy is swimming through the Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/spermy_06f49d1457.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPERM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPERM>>(v1);
    }

    // decompiled from Move bytecode v6
}

