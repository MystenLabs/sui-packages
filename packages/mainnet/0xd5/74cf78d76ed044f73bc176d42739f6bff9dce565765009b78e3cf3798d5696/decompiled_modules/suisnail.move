module 0xd574cf78d76ed044f73bc176d42739f6bff9dce565765009b78e3cf3798d5696::suisnail {
    struct SUISNAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISNAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISNAIL>(arg0, 6, b"SUISNAIL", b"Smoking Sui Snail", b"Smoking Sui Snail is a relaxed, witty companion representing your inner chill on the Sui network. Slow but surprisingly sharp, it keeps things smooth while taking its time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Otgd_Xu_J_400x400_7c905a207b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISNAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISNAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

