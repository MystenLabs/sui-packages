module 0x4fe2e6e35325eacd2acdf0d0f987e3413ffeb452af3508f25e0e143af9ab9e35::crocks {
    struct CROCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROCKS>(arg0, 6, b"Crocks", b"Crocks SUI", b"crocks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdsdgsdg_51cf2f6fe9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

