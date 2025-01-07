module 0x51bd75eb7a4414f06dd89e7722a1dec3818ccc02a060518c4c64e59a163f3dbb::soc {
    struct SOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOC>(arg0, 6, b"Soc", b"Cat in a soc", b"Its just a cat in a sock", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0563_2e588ec69e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

