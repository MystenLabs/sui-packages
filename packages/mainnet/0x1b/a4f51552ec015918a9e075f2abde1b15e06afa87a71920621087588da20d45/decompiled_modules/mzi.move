module 0x1ba4f51552ec015918a9e075f2abde1b15e06afa87a71920621087588da20d45::mzi {
    struct MZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MZI>(arg0, 9, b"MZI", b"Milad Zadi", b"Hurry to get rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/69e26200-32f1-405b-9e03-dfe16572cd70.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MZI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MZI>>(v1);
    }

    // decompiled from Move bytecode v6
}

