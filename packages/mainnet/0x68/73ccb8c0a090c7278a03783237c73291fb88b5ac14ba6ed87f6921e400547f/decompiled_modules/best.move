module 0x6873ccb8c0a090c7278a03783237c73291fb88b5ac14ba6ed87f6921e400547f::best {
    struct BEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEST>(arg0, 9, b"BEST", b"Shit", b"Shit is best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2845fe2-dcf3-4aa0-a279-5a39f71ca40b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

