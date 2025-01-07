module 0x70758c3dbbe8053db062170ae1959c6a2734f5362f91b13e7aef9310d2171f70::shamu {
    struct SHAMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAMU>(arg0, 6, b"SHAMU", b"Shamu", x"486f772063616e20796f752063616c6c20796f757273656c662061207768616c6520696620796f7520646f6e2774206861766520746865206d6f73742066616d6f7573207768616c6520746f2065766572206772616365207468652077617465727320696e20796f75722077616c6c65743f0a0a5265737420496e205065616365205368616d750a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0253_75148e691e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

