module 0xa605c380e1df918359f7cdc51d87fa895f97370abefc29f015a7e874b82447b8::nthng {
    struct NTHNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTHNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTHNG>(arg0, 9, b"NTHNG", b"Nothing", b"pr nthng? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4e904a8-46a8-41ed-99ba-6b16b51f061b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTHNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NTHNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

