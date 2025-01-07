module 0x4f47135737a7bc21d75ad1121d15d2684cb6464f03293cf0ebe16b2f4e747b90::zi {
    struct ZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZI>(arg0, 9, b"ZI", b"Guazi", b"Join the exciting project and get the chance to earn passive income ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f59c7cb5-303b-486f-b15a-1388574d11c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZI>>(v1);
    }

    // decompiled from Move bytecode v6
}

