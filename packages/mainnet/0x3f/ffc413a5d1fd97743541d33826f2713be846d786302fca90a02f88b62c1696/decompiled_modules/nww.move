module 0x3fffc413a5d1fd97743541d33826f2713be846d786302fca90a02f88b62c1696::nww {
    struct NWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: NWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NWW>(arg0, 6, b"NWW", b"NO WORLD WAR III", b"Join the movement on MOVEPUMP to stop WW III today chads!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wwticker_bac3432d2e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NWW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NWW>>(v1);
    }

    // decompiled from Move bytecode v6
}

