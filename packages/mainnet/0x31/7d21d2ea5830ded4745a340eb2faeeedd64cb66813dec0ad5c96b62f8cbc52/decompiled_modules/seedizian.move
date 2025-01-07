module 0x317d21d2ea5830ded4745a340eb2faeeedd64cb66813dec0ad5c96b62f8cbc52::seedizian {
    struct SEEDIZIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEDIZIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEDIZIAN>(arg0, 9, b"SEEDIZIAN", b"SEED", b"SEED Airdrop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1b54b32f-5a60-4ce9-8d3a-3bf88c6b40b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEDIZIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEEDIZIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

