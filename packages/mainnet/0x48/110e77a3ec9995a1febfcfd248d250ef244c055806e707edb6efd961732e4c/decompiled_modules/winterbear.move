module 0x48110e77a3ec9995a1febfcfd248d250ef244c055806e707edb6efd961732e4c::winterbear {
    struct WINTERBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINTERBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINTERBEAR>(arg0, 6, b"WINTERBEAR", b"Winter Bear On Sui", b"$WINTER BEAR ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5807530692207297756_39a50ece72.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINTERBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINTERBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

