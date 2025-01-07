module 0x9beaeda7866822c345c6b4f7ee956a37d901d902dfaea79ffbf499e44fc635fa::cwt {
    struct CWT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWT>(arg0, 9, b"CWT", b"Cawento", b"Cawento was inspired by what is happening in the world this days", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a9c288b7-b4a2-4ba9-bbd6-a0155cfa305e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CWT>>(v1);
    }

    // decompiled from Move bytecode v6
}

