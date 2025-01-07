module 0xbe5286bd90681af02aa04061c3f1c949621b270b0975edc25b6fb7b7404467a::baby {
    struct BABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABY>(arg0, 9, b"BABY", b"KING", b"Baby king", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/588d08ae-471b-44fd-996c-2846b919b3ce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABY>>(v1);
    }

    // decompiled from Move bytecode v6
}

