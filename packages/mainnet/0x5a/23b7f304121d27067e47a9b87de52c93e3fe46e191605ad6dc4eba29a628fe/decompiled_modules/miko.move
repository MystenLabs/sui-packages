module 0x5a23b7f304121d27067e47a9b87de52c93e3fe46e191605ad6dc4eba29a628fe::miko {
    struct MIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKO>(arg0, 9, b"MIKO", b"Mikail ", b"To expand my knowledge and experience with the cyroptocurrency ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee8198ba-2227-4259-a777-42cd3cd0ccc4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

