module 0x39569f3df786c62ed41517d7ef2e4ad71d8573cd60c9bb6f060d32de04c31cf9::apoc {
    struct APOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: APOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APOC>(arg0, 9, b"APOC", b"Apocalypse", b"Safe the World ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/21526f34-5240-4f68-9075-1ccf685a7531.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

