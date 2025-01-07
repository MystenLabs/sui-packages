module 0x1b68347b06dd3f19446822dee8279d25d27644cdbed9d6145a86cfca5c70b144::wawacat {
    struct WAWACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWACAT>(arg0, 6, b"WAWACAT", b"WawaCat Sui", b"Just can't stop WAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000629_2111fdb42c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAWACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

