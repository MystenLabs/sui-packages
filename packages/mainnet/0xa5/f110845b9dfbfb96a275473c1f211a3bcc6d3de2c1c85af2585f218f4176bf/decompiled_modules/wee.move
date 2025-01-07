module 0xa5f110845b9dfbfb96a275473c1f211a3bcc6d3de2c1c85af2585f218f4176bf::wee {
    struct WEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEE>(arg0, 6, b"Wee", b"WEEWEE on SUI", b"WEEEEEEEEEEEEEEEEEEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/weewee_bbfc608fca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

