module 0xd91c014ad42e65dd636bc66fe169b44733183983f873dbdbefc558c1420a1499::zodie {
    struct ZODIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZODIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZODIE>(arg0, 6, b"ZODIE", b"ZODIE ON SUI", b"$ZODIE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zofie_aec1c08643.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZODIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZODIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

