module 0x9554ac34745004f7c9453e06d609bf6926c32905c2bd24a60c7203c8ab44f81c::rama {
    struct RAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAMA>(arg0, 9, b"RAMA", b"Ramskiy", b"My first token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c56df351-ee55-4baf-938a-4b27e54e5baf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

