module 0xd0222063171d3b4db136c2c0e1e0faea4b839aa07c27d319020bcffb79558d3b::dra {
    struct DRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRA>(arg0, 9, b"DRA", b"DRAKE", b"Dreake", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cc71080b-00d0-48b3-a1cb-fd96e5d866af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

