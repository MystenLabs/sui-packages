module 0x8f1691c9550d0d12fed9519ba82a575d1bf81ac0b33fe5323e3bc0cf79a5321a::droppy {
    struct DROPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROPPY>(arg0, 6, b"Droppy", b"DroppyOnSui", b"Play the Droppy on Sui Telegram minigame", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Zrzut_ekranu_2024_09_18_135736_d0f8434840.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

