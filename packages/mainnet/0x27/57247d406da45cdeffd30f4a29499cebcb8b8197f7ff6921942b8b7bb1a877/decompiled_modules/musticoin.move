module 0x2757247d406da45cdeffd30f4a29499cebcb8b8197f7ff6921942b8b7bb1a877::musticoin {
    struct MUSTICOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSTICOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSTICOIN>(arg0, 9, b"MUSTICOIN", b"Musti", b"A coin for who loves nothing but smoke", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/16f0db09-6811-488b-9372-5bb86c1e9c32.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSTICOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSTICOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

