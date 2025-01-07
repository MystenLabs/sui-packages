module 0x337293a253ff2c3857ce214ca0e7ce6094817ead5aee3ef0aac3634958c1d11b::cp {
    struct CP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CP>(arg0, 6, b"CP", b"cat paste", b"using this brush your teeth everyday!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1101728468545_pic_b3ac88dcf4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CP>>(v1);
    }

    // decompiled from Move bytecode v6
}

