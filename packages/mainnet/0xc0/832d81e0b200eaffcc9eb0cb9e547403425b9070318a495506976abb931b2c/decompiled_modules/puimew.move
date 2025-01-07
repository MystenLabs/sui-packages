module 0xc0832d81e0b200eaffcc9eb0cb9e547403425b9070318a495506976abb931b2c::puimew {
    struct PUIMEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUIMEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUIMEW>(arg0, 9, b"PUIMEW", b"Wandercat", b"cutest creature on earth, god's masterpiece", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/311c6cc0-90e5-42d5-b97c-70b2423dba97.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUIMEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUIMEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

