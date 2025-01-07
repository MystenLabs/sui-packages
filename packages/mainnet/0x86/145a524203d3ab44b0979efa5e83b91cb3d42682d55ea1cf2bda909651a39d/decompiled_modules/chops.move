module 0x86145a524203d3ab44b0979efa5e83b91cb3d42682d55ea1cf2bda909651a39d::chops {
    struct CHOPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOPS>(arg0, 9, b"CHOPS", b"CHOP SUEY", b"suiming dog memecoin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.pinimg.com/1200x/05/1d/f0/051df0246a82c22d900a77eb62444f49.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHOPS>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOPS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

