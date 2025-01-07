module 0x613b221440fb1d67bd31c481ea5a9d235f12d6b71bc5842ff0a2a5bcab526601::bbks {
    struct BBKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBKS>(arg0, 6, b"BBKS", b"BlueBucks", b"Get ready to make a splash in the Sui ecosystem with BlueBucks.the freshest memecoin under the sea, brought to you by none other than your favorite blue lobster", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pppppp_969a53f1ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

