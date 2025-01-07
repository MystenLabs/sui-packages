module 0x2504659df823522b2f9fac031d5a2930973ab0f423e31d70382318e3c8b26643::suimuray {
    struct SUIMURAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMURAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMURAY>(arg0, 6, b"Suimuray", b"SUIMURAY", b"Suimuray is a unique memecoin that combines the iconic humor of the troll face with the spirit of Japanese samurai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241030_140445_b248284ab3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMURAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMURAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

