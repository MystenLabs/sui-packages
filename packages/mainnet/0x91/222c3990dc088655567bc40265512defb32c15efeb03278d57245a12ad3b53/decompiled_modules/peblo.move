module 0x91222c3990dc088655567bc40265512defb32c15efeb03278d57245a12ad3b53::peblo {
    struct PEBLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEBLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEBLO>(arg0, 6, b"PEBLO", b"SuiPeblo", b"Peblo is the legendary pepes on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/peblo_dd95ba567a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEBLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEBLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

