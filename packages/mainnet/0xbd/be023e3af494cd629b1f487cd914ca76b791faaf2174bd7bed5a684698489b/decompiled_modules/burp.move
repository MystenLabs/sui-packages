module 0xbdbe023e3af494cd629b1f487cd914ca76b791faaf2174bd7bed5a684698489b::burp {
    struct BURP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURP>(arg0, 6, b"BURP", b"BURP COIN", b"$BURP Because holding it in was never an option ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l_Iy_Borzh_400x400_31490d63ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURP>>(v1);
    }

    // decompiled from Move bytecode v6
}

