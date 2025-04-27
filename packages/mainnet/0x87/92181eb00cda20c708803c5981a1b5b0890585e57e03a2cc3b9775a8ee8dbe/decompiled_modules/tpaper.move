module 0x8792181eb00cda20c708803c5981a1b5b0890585e57e03a2cc3b9775a8ee8dbe::tpaper {
    struct TPAPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPAPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPAPER>(arg0, 6, b"TPAPER", b"Toilet Paper", b"you cant have a toilet without tpaper", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdfwe4_bd76a753c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPAPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TPAPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

