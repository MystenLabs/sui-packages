module 0x36fb80f50ae134df195647d099f8b4560e97a86be4cadbed0c1322828d94dd1b::vimb {
    struct VIMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIMB>(arg0, 6, b"VIMB", b"Voices In My Brain", b"A journey through the mind, uncovering the hidden voices that reside within us all - From the Silly to the Profound.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prop_69b67fe8db.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

