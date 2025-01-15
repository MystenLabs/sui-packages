module 0xf3ef42aa44251254e6482e9091bd7292c6d18e0db82e1d750d649ba23bf17952::doku {
    struct DOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOKU>(arg0, 6, b"DOKU", b"DOKU SUI", b"Doku Isn't your average crypto mascot. He's a quantum anomaly of joy, a walking paradox of financial wisdom and adorable confusion.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000144397_515f245296.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

