module 0x8a486b07e6c174363ebd3b1913cd72ab28a741e897cc901179f18969cb56c3a1::venko {
    struct VENKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: VENKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VENKO>(arg0, 6, b"VENKO", b"VenkoDog", b"The helpful Venco and the poor DOG in the crypto planet...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/JAY_ba54f7b031.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VENKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VENKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

