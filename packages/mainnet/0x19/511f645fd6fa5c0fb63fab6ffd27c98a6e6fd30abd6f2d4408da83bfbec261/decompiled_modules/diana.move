module 0x19511f645fd6fa5c0fb63fab6ffd27c98a6e6fd30abd6f2d4408da83bfbec261::diana {
    struct DIANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIANA>(arg0, 9, b"DIANA", b"Ankudinova", b"Official Diana's token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ff9b3214-d254-4607-9966-019f56138a01.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

