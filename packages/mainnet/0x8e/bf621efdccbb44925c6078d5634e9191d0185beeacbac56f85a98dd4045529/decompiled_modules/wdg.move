module 0x8ebf621efdccbb44925c6078d5634e9191d0185beeacbac56f85a98dd4045529::wdg {
    struct WDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDG>(arg0, 6, b"WDG", b"Worm Dog", b"Beware when you bite an apple.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zz_3f431fa2db.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

