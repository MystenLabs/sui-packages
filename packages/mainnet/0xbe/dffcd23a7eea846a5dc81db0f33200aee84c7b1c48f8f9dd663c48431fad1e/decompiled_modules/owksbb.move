module 0xbedffcd23a7eea846a5dc81db0f33200aee84c7b1c48f8f9dd663c48431fad1e::owksbb {
    struct OWKSBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWKSBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWKSBB>(arg0, 9, b"OWKSBB", b"hsksjw", b"snnsn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc2ccefa-48a8-46f9-b106-52dfe9c2845d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWKSBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWKSBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

