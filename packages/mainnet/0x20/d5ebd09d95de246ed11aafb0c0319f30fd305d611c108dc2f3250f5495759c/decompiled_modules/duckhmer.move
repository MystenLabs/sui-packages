module 0x20d5ebd09d95de246ed11aafb0c0319f30fd305d611c108dc2f3250f5495759c::duckhmer {
    struct DUCKHMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKHMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKHMER>(arg0, 6, b"DUCKHMER", b"Jeffrey Duckhmer", b"Hi im JEFFREY, yeah that cannibal duck, Im an og duck who only cares about its holders and will do whatever it takes for every single one of $DUCKHMER Holders to win.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/13_13023fe8db.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKHMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKHMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

