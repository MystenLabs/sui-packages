module 0x6b837353caf991b2afbb0a31a873e674e6467c0ad7d7d461ba0f3ac2a4f6e013::swtt {
    struct SWTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWTT>(arg0, 9, b"SWTT", b"WTT", b"World Trusted Token,The changing of though about money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1be6a219-c01a-470e-b8a3-6531d9fc6391.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

