module 0xb83b78ed009cc61e265837cce8f3d33762fd492075a989ee0021b6d891a7ed4f::ssui {
    struct SSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSUI>(arg0, 6, b"SSUI", b"Super SUI", b"In a digital world full of codes and transactions, a hero emerged: a small drop of water called Super SUI who lived in a vast ocean of data, where cryptocurrencies flowed like rivers and blockchains were towering mountains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739308656422.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

