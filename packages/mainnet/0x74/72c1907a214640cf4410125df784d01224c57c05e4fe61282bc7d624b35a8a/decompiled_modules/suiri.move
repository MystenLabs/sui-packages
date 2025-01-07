module 0x7472c1907a214640cf4410125df784d01224c57c05e4fe61282bc7d624b35a8a::suiri {
    struct SUIRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRI>(arg0, 6, b"SUIRI", b"SUIRII", b"SUIRI is siri but promax", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/174957_385673_385672_rc_143c8c7877.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRI>>(v1);
    }

    // decompiled from Move bytecode v6
}

