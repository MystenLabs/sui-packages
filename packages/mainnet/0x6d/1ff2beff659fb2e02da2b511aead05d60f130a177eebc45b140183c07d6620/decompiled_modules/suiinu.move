module 0x6d1ff2beff659fb2e02da2b511aead05d60f130a177eebc45b140183c07d6620::suiinu {
    struct SUIINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIINU>(arg0, 6, b"SUIINU", b"Sui Inu on SUI Chsin", b"Sui Inu - the water dog of SUI. Launching soon. Telegram - https://t.me/suisinu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suisinu_a0dbe02a66.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

