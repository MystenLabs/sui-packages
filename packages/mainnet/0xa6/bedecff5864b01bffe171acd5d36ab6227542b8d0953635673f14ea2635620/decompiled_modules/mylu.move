module 0xa6bedecff5864b01bffe171acd5d36ab6227542b8d0953635673f14ea2635620::mylu {
    struct MYLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYLU>(arg0, 6, b"MYLU", b"Mylu On Sui", b"Mylu - Ready for the big launch of the year ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021648_6b018cacef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYLU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYLU>>(v1);
    }

    // decompiled from Move bytecode v6
}

