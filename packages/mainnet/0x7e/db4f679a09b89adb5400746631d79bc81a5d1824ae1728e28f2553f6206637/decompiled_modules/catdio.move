module 0x7edb4f679a09b89adb5400746631d79bc81a5d1824ae1728e28f2553f6206637::catdio {
    struct CATDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATDIO>(arg0, 6, b"CATDIO", b"catardio", b"meow i'm cute i'm catardio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_2_J5_D8_WAAQ_Tn_Vg_bb0f981a25.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

