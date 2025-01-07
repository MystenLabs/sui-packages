module 0x7271f13b3bbe53da59ce804085fc21b61ab660bb02e70748badf94dfb8918b94::sos {
    struct SOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOS>(arg0, 6, b"SOS", b"SHARKS ON SUI", b"SUI is breaking out daily and only the real sharks will eat! Join our telegram for a free SOS NFT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rd1_Ax_G_Aplz8_Zffa4_Ud_RF_1_f1z9b_09a6d081cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

