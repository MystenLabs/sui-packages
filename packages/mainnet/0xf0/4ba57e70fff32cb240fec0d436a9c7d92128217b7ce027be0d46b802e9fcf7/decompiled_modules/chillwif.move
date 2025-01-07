module 0xf04ba57e70fff32cb240fec0d436a9c7d92128217b7ce027be0d46b802e9fcf7::chillwif {
    struct CHILLWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLWIF>(arg0, 6, b"CHILLWIF", b"Chill Wif Hat on SUI", x"546865206368696c6c65737420647564652077696620686174206f6e205355492e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A4_Ybk_Xgt_400x400_6bdd7ae24c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

