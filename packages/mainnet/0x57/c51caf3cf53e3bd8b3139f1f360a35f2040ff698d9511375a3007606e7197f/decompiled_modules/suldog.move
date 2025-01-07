module 0x57c51caf3cf53e3bd8b3139f1f360a35f2040ff698d9511375a3007606e7197f::suldog {
    struct SULDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SULDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SULDOG>(arg0, 6, b"SUlDOG", b"SUl DOG", b" SUlDOG SUlDOG SUlDOG SUlDOG SUlDOG  SUlDOG SUlDOG SUlDOG SUlDOG SUlDOG  SUlDOG SUlDOG SUlDOG SUlDOG SUlDOG  SUlDOG SUlDOG SUlDOG SUlDOG SUlDOG  SUlDOG SUlDOG SUlDOG SUlDOG SUlDOG  SUlDOG SUlDOG SUlDOG SUlDOG SUlDOG  SUlDOG SUlDOG SUlDOG SUlDOG SUlDOG  SUlDOG SUlDOG SUlDOG SUlDOG SUlDOG ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/QX_2l_XDF_400x400_eec2281bbd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SULDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SULDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

