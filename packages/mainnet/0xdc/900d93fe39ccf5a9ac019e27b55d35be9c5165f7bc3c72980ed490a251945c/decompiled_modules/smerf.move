module 0xdc900d93fe39ccf5a9ac019e27b55d35be9c5165f7bc3c72980ed490a251945c::smerf {
    struct SMERF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMERF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMERF>(arg0, 6, b"SMERF", b"SUIMERF", b"Dive into the enchanting world of #SMERF, a #memecoin inspired by the beloved Smurf characters!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_77d711815b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMERF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMERF>>(v1);
    }

    // decompiled from Move bytecode v6
}

