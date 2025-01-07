module 0xfd52b2a3e59336d409c0cb2831ef1b7e34002c8d05d02ad3431d026e2090e32d::habibi {
    struct HABIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HABIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HABIBI>(arg0, 6, b"HABIBI", b"HABIBICAT", b"In the land of $HABIBI, where luxury meets loyalty, only the finest prosper.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/habibi_1_81134c8379.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HABIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HABIBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

