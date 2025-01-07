module 0x7e817778b91dd5481f054ca76283d137b8fd0eeb0731f8b0c476c7a4aafbffeb::badr {
    struct BADR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADR>(arg0, 6, b"Badr", b"BadrTheRugpullGoatRider", b"Best farming dev deserves his own token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241017_160147_d3cdce89ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BADR>>(v1);
    }

    // decompiled from Move bytecode v6
}

