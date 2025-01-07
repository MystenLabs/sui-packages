module 0xede569460c1a955529b048a49c95367841eb4ff88599e4985abd5dd65f4cb147::trump4724 {
    struct TRUMP4724 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP4724, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP4724>(arg0, 9, b"TRUMP4724", b"Trump2024", b"Meme about America President 47th", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d41447bd-fa28-4383-ae98-a4ec68e1f662.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP4724>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP4724>>(v1);
    }

    // decompiled from Move bytecode v6
}

