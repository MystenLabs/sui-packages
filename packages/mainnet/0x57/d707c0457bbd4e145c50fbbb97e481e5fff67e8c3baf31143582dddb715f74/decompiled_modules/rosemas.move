module 0x57d707c0457bbd4e145c50fbbb97e481e5fff67e8c3baf31143582dddb715f74::rosemas {
    struct ROSEMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSEMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSEMAS>(arg0, 6, b"Rosemas", b"Merry Rosemas", b"Merry Rosemas and Happy New Year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rosemas_GIF_bc1deb3e02.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSEMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROSEMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

