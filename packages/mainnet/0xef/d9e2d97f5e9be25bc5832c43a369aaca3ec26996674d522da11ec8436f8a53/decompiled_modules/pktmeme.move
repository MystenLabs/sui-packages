module 0xefd9e2d97f5e9be25bc5832c43a369aaca3ec26996674d522da11ec8436f8a53::pktmeme {
    struct PKTMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKTMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKTMEME>(arg0, 9, b"PKTMEME", b"Puttotalk", b"Talk or silen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8322f9f1-8382-4b3c-9ef9-2d6b8b8b0389.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKTMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PKTMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

