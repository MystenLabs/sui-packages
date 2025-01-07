module 0xb09aab8c806a7a0835649e89e4f2705682cf96fc374ac74605cdc1d8eff5d2af::mudi {
    struct MUDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUDI>(arg0, 9, b"MUDI", b"Mudi", b"The first Dog memecoin under Sui Ecosystem which is very intelligent and very lively. My Dog lover come support this community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b819de2a-bb91-4212-a16f-50c02caa24c5-IMG_6553.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

