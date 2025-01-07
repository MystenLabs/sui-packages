module 0x17a55539572e51b16503fa6e021d0ca7140d1be210fd11b7ee43b670cdfd287e::memg {
    struct MEMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMG>(arg0, 9, b"MEMG", b"Memegold", b"Memegold is a fun, community-driven meme cryptocurrency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f4619d5-bf91-467a-b576-5e51d2c44915.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMG>>(v1);
    }

    // decompiled from Move bytecode v6
}

