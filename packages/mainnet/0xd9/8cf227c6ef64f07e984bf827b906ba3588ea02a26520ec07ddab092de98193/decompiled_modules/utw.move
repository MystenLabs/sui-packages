module 0xd98cf227c6ef64f07e984bf827b906ba3588ea02a26520ec07ddab092de98193::utw {
    struct UTW has drop {
        dummy_field: bool,
    }

    fun init(arg0: UTW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UTW>(arg0, 6, b"UTW", b"UnderTheWater", b"Hello Im Under The Water...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hello_i_am_under_the_water_3b6912ba63.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UTW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UTW>>(v1);
    }

    // decompiled from Move bytecode v6
}

