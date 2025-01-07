module 0x886edffab18af65430e31b51e0b9b3e49e245ddb20f21efc622210a4497f84b5::dogsui {
    struct DOGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSUI>(arg0, 9, b"DOGSUI", b"Dogs", b"To the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6a3e007b-8db8-4b3a-83c9-03a207b4a49a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

