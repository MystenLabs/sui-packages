module 0x24a16fa8c387d3b1f4b908de950c024ba6d4ee67c095628ebdc1633dd74b4501::hpy {
    struct HPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HPY>(arg0, 6, b"HPY", b"Hoppy", b"Hoppy Hoppy Happy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R34_S_KQ_400x400_6c3d1c087d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

