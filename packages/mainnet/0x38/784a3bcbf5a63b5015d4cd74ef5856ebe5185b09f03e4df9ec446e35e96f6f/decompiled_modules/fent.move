module 0x38784a3bcbf5a63b5015d4cd74ef5856ebe5185b09f03e4df9ec446e35e96f6f::fent {
    struct FENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENT>(arg0, 6, b"FENT", b"George Droyd AI", b"Pure f***ing chaos fueling George Droyd AI. This isn't your grandmas token$FENT pumps hard, wrecks harder, and leaves no Narcan for the weak. You're either in or you're f***ed. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2273_033d53f13f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

