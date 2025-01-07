module 0x49e818d2eeea385220bf33724a90acc52e7ff196d2a052ac6816682c528be05::dream {
    struct DREAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DREAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DREAM>(arg0, 6, b"Dream", b"life could be dream", b"life could be dream ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bildschirmfoto_2024_09_26_um_15_06_06_1218ac6648.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DREAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DREAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

