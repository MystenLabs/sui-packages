module 0x513f5689eb565e51f980bfe542f431277c8b9403ddb51e7a0fc747dd1316cbc2::dfish {
    struct DFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFISH>(arg0, 6, b"DFISH", b"Dogefish", b"A Doge Worthy Of The Sui Waters!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dogefish_ba83c3ddbb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

