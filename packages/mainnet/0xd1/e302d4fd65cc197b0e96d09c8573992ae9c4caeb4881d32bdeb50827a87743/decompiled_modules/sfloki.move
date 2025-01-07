module 0xd1e302d4fd65cc197b0e96d09c8573992ae9c4caeb4881d32bdeb50827a87743::sfloki {
    struct SFLOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFLOKI>(arg0, 6, b"SFLOKI", b"Sui FLOKI", b"FLOKI IS POPULAR MEME, so SFLOKI Bring back meme branding", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3586_b9b2377d81.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFLOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFLOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

