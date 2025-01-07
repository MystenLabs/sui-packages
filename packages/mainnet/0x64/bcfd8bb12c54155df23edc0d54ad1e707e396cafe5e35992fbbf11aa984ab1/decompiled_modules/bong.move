module 0x64bcfd8bb12c54155df23edc0d54ad1e707e396cafe5e35992fbbf11aa984ab1::bong {
    struct BONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONG>(arg0, 6, b"BONG", b"Bong Cat", b"The most high cat on The internet $Bong Cat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logoo_8ed79ed52e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

