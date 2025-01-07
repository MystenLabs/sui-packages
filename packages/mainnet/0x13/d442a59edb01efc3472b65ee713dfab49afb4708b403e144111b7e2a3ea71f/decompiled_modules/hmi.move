module 0x13d442a59edb01efc3472b65ee713dfab49afb4708b403e144111b7e2a3ea71f::hmi {
    struct HMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMI>(arg0, 6, b"Hmi", b"Hmhmeee", b"Where is my bnanannananan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BB_1n_OG_Ba_32dca83d65.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

