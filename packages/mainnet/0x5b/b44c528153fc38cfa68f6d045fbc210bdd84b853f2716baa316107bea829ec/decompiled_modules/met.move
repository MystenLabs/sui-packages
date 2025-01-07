module 0x5bb44c528153fc38cfa68f6d045fbc210bdd84b853f2716baa316107bea829ec::met {
    struct MET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MET>(arg0, 6, b"MET", b"circular 2.0", b"2065 un lugar sostenible", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241018_162856_Photo_Editor49_cfd6df66b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MET>>(v1);
    }

    // decompiled from Move bytecode v6
}

