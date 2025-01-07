module 0xe34e427510d5b9b4274255d418ae5b30b6999012dfcc13e0974f10b8183cb3bf::bprs {
    struct BPRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPRS>(arg0, 9, b"BPRS", b"BrokePARIS", b"I love this picture and choose it fore the token avatar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9fe75052-90c0-452a-8c07-89bd9fcdd10e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BPRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

