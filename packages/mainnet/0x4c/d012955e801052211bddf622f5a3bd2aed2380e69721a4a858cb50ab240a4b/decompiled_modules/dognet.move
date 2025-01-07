module 0x4cd012955e801052211bddf622f5a3bd2aed2380e69721a4a858cb50ab240a4b::dognet {
    struct DOGNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGNET>(arg0, 6, b"DOGNET", b"dogwifmagnet", b"Magnet is the only thing that pull up the market in these days", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241013_020158_741_ae496cdcea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGNET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGNET>>(v1);
    }

    // decompiled from Move bytecode v6
}

