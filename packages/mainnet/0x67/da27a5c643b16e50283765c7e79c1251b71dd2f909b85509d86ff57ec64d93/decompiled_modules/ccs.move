module 0x67da27a5c643b16e50283765c7e79c1251b71dd2f909b85509d86ff57ec64d93::ccs {
    struct CCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCS>(arg0, 9, b"CCS", b"Cruise shi", b"What we do with you is traveling by cruise ship", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6769e9fe-0382-4976-b7e8-df420b8781fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

