module 0xc62d1e9fe99d362f53cc1f83768431bd94c16c0de01871a1375a1d9e3381141e::casperghost {
    struct CASPERGHOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASPERGHOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASPERGHOST>(arg0, 6, b"CASPERGHOST", b"Casper Ghost", b"Casper is the only ghost that won't scare you on Halloween. Because he is the most friendly ghost in the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030908_ee885e2fb0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASPERGHOST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASPERGHOST>>(v1);
    }

    // decompiled from Move bytecode v6
}

