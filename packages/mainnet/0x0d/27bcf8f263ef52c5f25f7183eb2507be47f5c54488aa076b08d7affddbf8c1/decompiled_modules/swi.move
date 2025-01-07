module 0xd27bcf8f263ef52c5f25f7183eb2507be47f5c54488aa076b08d7affddbf8c1::swi {
    struct SWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWI>(arg0, 9, b"SWI", b"Suwei", b"Uniquely indivisible suwei", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54a8ad4a-523b-4158-a3c0-af0c2d39fc19.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

