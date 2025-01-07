module 0xca978202d986d9d5dbbf1aa28e33eaf672f91f15e8ed53e0c52911c3b66bb9da::oeknd {
    struct OEKND has drop {
        dummy_field: bool,
    }

    fun init(arg0: OEKND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OEKND>(arg0, 9, b"OEKND", b"jenen", b"bebev", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/97188ccc-2a13-4233-8224-6ea4ce3aaf79.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OEKND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OEKND>>(v1);
    }

    // decompiled from Move bytecode v6
}

