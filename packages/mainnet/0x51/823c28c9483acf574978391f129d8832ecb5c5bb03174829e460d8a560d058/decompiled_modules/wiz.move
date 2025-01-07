module 0x51823c28c9483acf574978391f129d8832ecb5c5bb03174829e460d8a560d058::wiz {
    struct WIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIZ>(arg0, 6, b"WIZ", b"WIZARD CAT", b"The Wizard Cat casting magical spells on Sui $WIZ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_634d79b15a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

