module 0xa999405071aeda85d2d22f0eac08dd6b71facb421e3f56b7d805cf11be1e1f40::angcat {
    struct ANGCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGCAT>(arg0, 9, b"ANGCAT", b"ANGRYCAT ", b"ANGRYCAT wewe inspired by original wewe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8edf452c-4a13-494b-a573-f3aede39f538.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANGCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

