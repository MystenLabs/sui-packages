module 0xfbec1ed06c99695698cd2a80137b5bd6488f3ff6a85f2533d68f8512985060a0::flop {
    struct FLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOP>(arg0, 6, b"Flop", b"Green Flop", b"$FLOP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000170134_3c05e84f8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

