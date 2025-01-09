module 0xffc0f02d5e259e8abba73a0e39eee89791db0317149bb8115163e25d9a9c9d38::gpt {
    struct GPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GPT>(arg0, 6, b"GPT", b"Greenland Potential Token by SuiAI", b"A token representing the potential of Greenland's resources and strategic value. Backed by the belief in Greenland's future as a key player in the global economy, potentially as part of the United States.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Gemini_Generated_Image_86ksas86ksas86ks_e8e20b2d96.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GPT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

