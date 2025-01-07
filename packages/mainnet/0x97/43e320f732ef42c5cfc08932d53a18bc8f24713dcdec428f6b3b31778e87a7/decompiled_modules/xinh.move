module 0x9743e320f732ef42c5cfc08932d53a18bc8f24713dcdec428f6b3b31778e87a7::xinh {
    struct XINH has drop {
        dummy_field: bool,
    }

    fun init(arg0: XINH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XINH>(arg0, 9, b"XINH", b"wewelinh", x"c491676466682067c3a9677320c3aa666520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/10ad0c0a-1386-41a1-9e0c-64f25d8ec2c2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XINH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XINH>>(v1);
    }

    // decompiled from Move bytecode v6
}

