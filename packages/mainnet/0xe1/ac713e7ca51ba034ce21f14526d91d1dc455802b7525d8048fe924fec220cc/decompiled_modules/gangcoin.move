module 0xe1ac713e7ca51ba034ce21f14526d91d1dc455802b7525d8048fe924fec220cc::gangcoin {
    struct GANGCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANGCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANGCOIN>(arg0, 9, b"GANGCOIN", b"GANG", b"Gang gang gang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0a5e952-e3ee-4bbe-bdd0-288e019df323.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANGCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GANGCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

