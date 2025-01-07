module 0x19967425c1eabdf8550942af0f73c870c51e1031226d91f6cd6578ae02545529::cmoon {
    struct CMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMOON>(arg0, 6, b"CMOON", b"CATMOONITY", b"Welcome to the Catmoonity  where cats rule the cosmos!  Get ready for an epic journey to uncharted planets. Let's make the  cosmos great again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_022187daf7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

