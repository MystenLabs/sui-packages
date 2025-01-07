module 0x8762fa1b605b7d0196c9f13af9b84994a3e2703561f65038887e93671d62f008::suibainu {
    struct SUIBAINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBAINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBAINU>(arg0, 6, b"SUIBAINU", b"Suiba Inu", b"The loyal pup of Sui, wagging its tail and splashing around. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suiba_4514fba7e1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBAINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBAINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

