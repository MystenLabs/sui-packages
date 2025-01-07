module 0xdfb150793b768079e6eef90a6fc30e02295f4323156cf8f4545af717c8a0ef21::suibainu {
    struct SUIBAINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBAINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBAINU>(arg0, 6, b"SUIBAINU", b"Suiba Inu", b"Join the Suiba Inu revolution, where every coin is a good boy! Bow-wow to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suibainu_859b2030c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBAINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBAINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

