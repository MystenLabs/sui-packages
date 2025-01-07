module 0xe149d4c6acf10d90bed774034225d0b4fae3530dc664fc817d5036157b994929::apoc {
    struct APOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: APOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APOC>(arg0, 9, b"APOC", b"Apocalypse", b"Safe the World ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/07a8367c-435d-47a3-9172-6ce2a1e0a984.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

