module 0xdb2827fc9f772a3f17e4e5af005fae210ed97bf8357df3ce6042a46d29e98d83::sunb {
    struct SUNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNB>(arg0, 6, b"SUNB", b"BLUESUN", b"Its that real?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bluesun_soho_big_43a96459ed.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNB>>(v1);
    }

    // decompiled from Move bytecode v6
}

