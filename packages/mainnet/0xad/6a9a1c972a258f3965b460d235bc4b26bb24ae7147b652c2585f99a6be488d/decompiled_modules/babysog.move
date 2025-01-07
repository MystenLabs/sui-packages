module 0xad6a9a1c972a258f3965b460d235bc4b26bb24ae7147b652c2585f99a6be488d::babysog {
    struct BABYSOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSOG>(arg0, 6, b"BABYSOG", b"BabySealDog", b"$BABYSOG is $SOGS baby following the steps of his father", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GK_19_Khla_UA_Aq0jb_7b718117d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYSOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

