module 0x5f45b89ae193eb69862ef02047808e083764c5a6191232c77c033fa4feb8cbde::jin {
    struct JIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIN>(arg0, 6, b"JIN", b"Jin Meme", b"JIN - lucky memecoin talisman for the Year of the Snake! He stands as the embodiment of luck and prosperity, filling his temple with treasures of wealth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_43f28d1bf2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

