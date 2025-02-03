module 0x3e8f9a32410b873d7e19270700ba8c461ce348418fb048b06990a34b660b65cb::pain {
    struct PAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAIN>(arg0, 6, b"PAIN", b"PAIN SUI", b"NO $PAIN, NO GAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b_Hx_O_Ciw1_400x400_1eb734819f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

