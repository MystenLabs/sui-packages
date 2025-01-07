module 0xaccad23ceadb793812b5c081208dcddfb300a1ffeac573cd5eb5515cc89139d0::esi {
    struct ESI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESI>(arg0, 9, b"ESI", b"Sisi", b"Khorzo khan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dd48ae4f-a8fc-4792-ab86-b5c6f5de31d1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ESI>>(v1);
    }

    // decompiled from Move bytecode v6
}

