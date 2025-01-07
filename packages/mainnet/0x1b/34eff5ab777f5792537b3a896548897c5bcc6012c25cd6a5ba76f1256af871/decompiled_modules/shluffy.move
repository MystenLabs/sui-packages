module 0x1b34eff5ab777f5792537b3a896548897c5bcc6012c25cd6a5ba76f1256af871::shluffy {
    struct SHLUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHLUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHLUFFY>(arg0, 6, b"Shluffy", b"STRAWHAT", b"The King of pirates is now sailing in the sui ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241003_160936_f87cf543b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHLUFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHLUFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

