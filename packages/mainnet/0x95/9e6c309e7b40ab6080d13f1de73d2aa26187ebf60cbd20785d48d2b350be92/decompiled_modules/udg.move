module 0x959e6c309e7b40ab6080d13f1de73d2aa26187ebf60cbd20785d48d2b350be92::udg {
    struct UDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UDG>(arg0, 6, b"UDG", b"UPDOG", b"PDOG ONLY GOES UP DAWG. ITS PRIMED FOR UPTOBER AND READY FOR THE NEW BULL RUN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/smiling_dog_meme_beltschazar_transparent_81dd5a206b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

