module 0xce1b0b78f6438fe7e858d6e6f7846a5a7da000bf3ad8060c038650d9d91466c8::gbt {
    struct GBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBT>(arg0, 6, b"GBT", b"GABUT", b"Gabut, is rising star in the meme game universe on the SUI blockchain. Gabut brings a playful twist with its lama-themed charm. Embrace the whimsical world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gemini_Generated_Image_kpvk3bkpvk3bkpvk_42528b88f9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

