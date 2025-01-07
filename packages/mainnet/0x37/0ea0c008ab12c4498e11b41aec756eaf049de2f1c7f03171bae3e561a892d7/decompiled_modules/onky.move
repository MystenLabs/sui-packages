module 0x370ea0c008ab12c4498e11b41aec756eaf049de2f1c7f03171bae3e561a892d7::onky {
    struct ONKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONKY>(arg0, 6, b"Onky", b"Onky Monkey", b"Wild monkeys are smart and kind, used to living alone and exploring the wild jungle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001973_8b28947985.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

