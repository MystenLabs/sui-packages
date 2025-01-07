module 0x69e77602e1b126f874b8e69f59d539f0a044e8280c72ddd6af1417aa751ea4ac::ptrump {
    struct PTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTRUMP>(arg0, 6, b"PTRUMP", b"Pepe trump", x"596f752063616e2774207374756d7020746865205472756d700a0a24505452554d5020474f4e4e41205341564520555320414c4c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000305624_111851a606.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

