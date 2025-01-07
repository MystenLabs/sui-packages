module 0x6f6cec6e7958cd54160ba3f75d8d3c0fff61e4701b6ffd923b8eeaba7a98dbc::badger {
    struct BADGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADGER>(arg0, 6, b"BADGER", b"BadgerBadger sui", b"BadgerBadger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_42_19448e6e24.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BADGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

