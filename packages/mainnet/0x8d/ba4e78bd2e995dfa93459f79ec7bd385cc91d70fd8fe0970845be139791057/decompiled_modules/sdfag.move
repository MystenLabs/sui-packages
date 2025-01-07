module 0x8dba4e78bd2e995dfa93459f79ec7bd385cc91d70fd8fe0970845be139791057::sdfag {
    struct SDFAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDFAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDFAG>(arg0, 9, b"SDFAG", b"NG", b" BX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a91da7e3-a252-4c62-9e25-68b841c132fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDFAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDFAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

