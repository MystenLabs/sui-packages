module 0x1cf8421311539fbcff767a4038f5fe72d631b7955c498e608b60a490dedbd99f::zong {
    struct ZONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZONG>(arg0, 6, b"ZONG", b"Na Zong", b"Nakula (Na Zong) the proboscis monkey is famous for his nose. This handsome monkey is currently only exhibited in Chimelong Wildlife Park in China", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_1_a9c88d2bdd.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

