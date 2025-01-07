module 0x72fdac8dd376859e5de15eff7ea65bf20fab69a1ba8eab79541a496f46488c8c::drog {
    struct DROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROG>(arg0, 6, b"DROG", b"Drog is dog", b"Tried to bark, but all I did was croak.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fb12280a81cb08364fd22ae9992966be_175cb6ada8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

