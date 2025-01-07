module 0xb959e7e74578506eddf9f53a3a7e2d2006c8837b5044f8fa00b37fb202954a4c::fpepe {
    struct FPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FPEPE>(arg0, 9, b"FPEPE", b"Father Pepe On Sui", b"Let us pray together for peace and justice in the world and help those in need, always ready to share the love of God.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=184,fit=crop,q=95/dJo6lxKlK9T7ERqw/group-1-mxBZzyD4W9f2eLyP.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FPEPE>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FPEPE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FPEPE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

