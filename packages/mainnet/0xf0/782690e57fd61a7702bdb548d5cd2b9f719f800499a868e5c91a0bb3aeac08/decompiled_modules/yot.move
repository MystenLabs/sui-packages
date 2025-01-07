module 0xf0782690e57fd61a7702bdb548d5cd2b9f719f800499a868e5c91a0bb3aeac08::yot {
    struct YOT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<YOT>, arg1: 0x2::coin::Coin<YOT>) : u64 {
        0x2::coin::burn<YOT>(arg0, arg1)
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<YOT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YOT>>(0x2::coin::mint<YOT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: YOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOT>(arg0, 6, b"YOT", b"YO Token", b"YOT is the native token of Yield Optimization Terminal.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://mqer437zuw4u4ntyk5aftetyb4fbwuzvvaygwpfuk5mw6w75dkna.arweave.net/ZAkeb_mluU42eFdAWZJ4DwobUzWoMGs8tFdZb1v9Gpo")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

