module 0x2f3faa418c369629714112aae1ed1a165f3ad614804a20138ba628deff1b5100::xvii {
    struct XVII has drop {
        dummy_field: bool,
    }

    fun init(arg0: XVII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XVII>(arg0, 9, b"XVII", b"Srk", b"Xtra_Bullrun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8b80b0de-23e4-4a4c-a58d-e4efc51d3f8c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XVII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XVII>>(v1);
    }

    // decompiled from Move bytecode v6
}

