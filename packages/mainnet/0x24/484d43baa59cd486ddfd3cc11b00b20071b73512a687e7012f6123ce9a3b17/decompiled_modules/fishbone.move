module 0x24484d43baa59cd486ddfd3cc11b00b20071b73512a687e7012f6123ce9a3b17::fishbone {
    struct FISHBONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHBONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHBONE>(arg0, 6, b"FISHBONE", b"Fishbone", x"47455420484f4f4b45442077697468202446495348424f4e45210a412046494e2d746173746963204d656d6520636f696e20776974682061204269746521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002283_c63d7882f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHBONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHBONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

