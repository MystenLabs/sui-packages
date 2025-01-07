module 0xa4336268c2f23c50f3869312ae190911d1bafcd3936e18b7bf6762ac197690c8::selfie {
    struct SELFIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SELFIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SELFIE>(arg0, 6, b"SELFIE", b"Selfie Dog", b"Selfie Dog, now on SUI !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_PROEQO_400x400_3683fc1c72.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SELFIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SELFIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

