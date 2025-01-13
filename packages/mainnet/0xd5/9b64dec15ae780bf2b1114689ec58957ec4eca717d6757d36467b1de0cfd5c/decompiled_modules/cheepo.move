module 0xd59b64dec15ae780bf2b1114689ec58957ec4eca717d6757d36467b1de0cfd5c::cheepo {
    struct CHEEPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEEPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEEPO>(arg0, 6, b"CHEEPO", b"cheepo", b"The goat of sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000142481_127f9c27e4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEEPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEEPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

