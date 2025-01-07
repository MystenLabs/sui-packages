module 0xfa8098578af15ee129392a9c53d07d68fd5ab38e99d71cd83b5066e6973b0731::vft {
    struct VFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VFT>(arg0, 6, b"VFT", b"Vesse Food Tracker", b"Vesse Food Tracker lets you upload your food images for instant AI analysis. Discover detailed breakdowns of sugars, fat, protein, and more at a glance. Stay informed about your meals with this fast, free, and easy-to-use tool! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Component_69_5d232632f1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

