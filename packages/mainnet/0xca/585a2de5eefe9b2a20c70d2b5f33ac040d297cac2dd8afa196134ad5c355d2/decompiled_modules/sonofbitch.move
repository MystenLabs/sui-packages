module 0xca585a2de5eefe9b2a20c70d2b5f33ac040d297cac2dd8afa196134ad5c355d2::sonofbitch {
    struct SONOFBITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONOFBITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONOFBITCH>(arg0, 9, b"SONOFBITCH", b"Satanyahu", b"The kid's killer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/08ed5cff-4acf-464b-bba2-21e6386d1102.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONOFBITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SONOFBITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

