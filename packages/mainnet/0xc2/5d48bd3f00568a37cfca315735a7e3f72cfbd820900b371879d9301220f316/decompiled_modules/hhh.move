module 0xc25d48bd3f00568a37cfca315735a7e3f72cfbd820900b371879d9301220f316::hhh {
    struct HHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHH>(arg0, 6, b"HHH", b"SeaHorse", x"496e20537569206f6365616e2c20612073656120686f727365207468617420626f6173747320616e20732d6c696e6520626f64792069732065786572636973696e6720746f207374617920696e2073686170652e20546861742066696775726520686173206265636f6d65206120706f70756c6172206d656d65206f6620746865205375692065636f73797374656d2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1002_7dc7e59546.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

