module 0xfac96415027d40f33bc5acec82744fd8468c651c2aa90b0a8c6c2be8daff10d0::shfl {
    struct SHFL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHFL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHFL>(arg0, 9, b"SHFL", b"Shuffle", b"shuffle crypto coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5ca4aa17-a76c-404a-a30a-c80995be1ca1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHFL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHFL>>(v1);
    }

    // decompiled from Move bytecode v6
}

