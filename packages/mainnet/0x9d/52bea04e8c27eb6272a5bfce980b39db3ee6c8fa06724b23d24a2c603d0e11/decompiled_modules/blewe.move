module 0x9d52bea04e8c27eb6272a5bfce980b39db3ee6c8fa06724b23d24a2c603d0e11::blewe {
    struct BLEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLEWE>(arg0, 6, b"BLEWE", b"BLEWE ON SUI", b"BLEWE is laid back and carefree living in a whimsical world, embodying the playful and surreal essence of the book Mindviscosity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fefe_swingd95f_c35dd7c6da.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

