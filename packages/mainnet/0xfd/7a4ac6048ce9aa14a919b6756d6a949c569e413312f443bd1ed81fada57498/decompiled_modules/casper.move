module 0xfd7a4ac6048ce9aa14a919b6756d6a949c569e413312f443bd1ed81fada57498::casper {
    struct CASPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASPER>(arg0, 6, b"CASPER", b"Casper the Sui", b"The friendliest ghost youll ever meet on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Casper_1_ae2983e54e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

