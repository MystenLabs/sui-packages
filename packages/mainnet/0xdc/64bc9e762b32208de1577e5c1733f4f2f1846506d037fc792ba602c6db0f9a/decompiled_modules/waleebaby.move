module 0xdc64bc9e762b32208de1577e5c1733f4f2f1846506d037fc792ba602c6db0f9a::waleebaby {
    struct WALEEBABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALEEBABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALEEBABY>(arg0, 9, b"WALEEBABY", b"Waly", b"Crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5e7026ec-699d-4b8b-947f-c41c77e0bac7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALEEBABY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALEEBABY>>(v1);
    }

    // decompiled from Move bytecode v6
}

