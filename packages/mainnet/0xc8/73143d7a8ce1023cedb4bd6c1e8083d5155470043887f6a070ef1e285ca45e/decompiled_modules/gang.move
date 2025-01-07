module 0xc873143d7a8ce1023cedb4bd6c1e8083d5155470043887f6a070ef1e285ca45e::gang {
    struct GANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANG>(arg0, 9, b"GANG", b"GANGSTER", b"GANGSTER LOVE = GANGSTER MONEY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/50f02dce-8cbe-4b9f-b05b-2bbc3b3dfb98.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

