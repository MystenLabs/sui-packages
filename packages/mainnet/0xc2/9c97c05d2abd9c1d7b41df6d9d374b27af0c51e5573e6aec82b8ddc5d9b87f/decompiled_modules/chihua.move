module 0xc29c97c05d2abd9c1d7b41df6d9d374b27af0c51e5573e6aec82b8ddc5d9b87f::chihua {
    struct CHIHUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIHUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIHUA>(arg0, 9, b"CHIHUA", b"Chihuahua", b"Chihuahua dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3dc34ecb-eaa8-4263-a437-799cebbfbe15.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIHUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIHUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

