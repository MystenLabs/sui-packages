module 0x95ff3a49b290f1278b113c0d2fb03009a5398ab66a0621bba63066de04f61070::hawktuah {
    struct HAWKTUAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAWKTUAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAWKTUAH>(arg0, 6, b"HAWKTUAH", b"HAWK TUAH", b"HAWK TUAH ! SPIT ON THAT TANG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/da_241_hawk_tuah_02_bdc3852689.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAWKTUAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAWKTUAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

