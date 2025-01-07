module 0xd0c27e99089919dcb43416c27a75349ea74d861464fb7542dc9c1e1c53f8cef3::btt {
    struct BTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTT>(arg0, 6, b"BTT", b"BIT-TOM", b"Bit-tom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003087_dd64d9f542.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

