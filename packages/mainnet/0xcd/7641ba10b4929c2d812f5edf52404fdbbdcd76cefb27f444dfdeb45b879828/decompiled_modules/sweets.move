module 0xcd7641ba10b4929c2d812f5edf52404fdbbdcd76cefb27f444dfdeb45b879828::sweets {
    struct SWEETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWEETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWEETS>(arg0, 6, b"SWEETS", b"Suisweets", b"Driven by an experienced team who has been active in Web3 since 2021, $SWEETS is primed for massive success. SWEETS contains a perfect blend between the meme, branding, and Professionalism", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049405_53ad6560c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWEETS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWEETS>>(v1);
    }

    // decompiled from Move bytecode v6
}

