module 0xab439d7720fbf62c9d1191d03e18bcefb3e956dd75b275d8f3b02dc35d55460::suicode {
    struct SUICODE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICODE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICODE>(arg0, 6, b"SUICODE", b"SuiCode", b"Suicode: A simple, unique code solution for Aptos, designed to streamline and simplify coding tasks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000317731_f5d09ad443.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICODE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICODE>>(v1);
    }

    // decompiled from Move bytecode v6
}

