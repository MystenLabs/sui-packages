module 0x57f973c702ec73fecfd3644935e42cb0a18b64383f1b0b98ae10c028faceb877::cactus {
    struct CACTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CACTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CACTUS>(arg0, 6, b"CACTUS", b"CACTUS TOKEN", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_removebg_preview_8452a4a0ad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CACTUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CACTUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

