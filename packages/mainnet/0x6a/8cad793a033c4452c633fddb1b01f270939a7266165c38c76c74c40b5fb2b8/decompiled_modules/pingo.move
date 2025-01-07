module 0x6a8cad793a033c4452c633fddb1b01f270939a7266165c38c76c74c40b5fb2b8::pingo {
    struct PINGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINGO>(arg0, 6, b"PINGO", b"PINGO SUI", b"Pingo adorable yet cheeky penguin mascot, Pingo aims to be a symbol of resilience and adaptability, much like the penguin itself", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_26_at_18_28_18_58023748f4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

