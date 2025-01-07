module 0xa3923b4b51e46df816d634bf89166d387edb4d220f9574c6c4f1fe4943257335::all {
    struct ALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALL>(arg0, 6, b"ALL", b"Aladdin's lamp", b"Everyone longs to have the Divine Light.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/041_f7725e0c14.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

