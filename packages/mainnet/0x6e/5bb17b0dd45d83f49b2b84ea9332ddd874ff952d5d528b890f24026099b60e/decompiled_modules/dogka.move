module 0x6e5bb17b0dd45d83f49b2b84ea9332ddd874ff952d5d528b890f24026099b60e::dogka {
    struct DOGKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGKA>(arg0, 9, b"DOGKA", b"Kaka", b"Dogs kaka ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea080246-d24c-4078-b501-781c694a6f82.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

