module 0x1b22b2d9a0bac5bd68f489cccc7174409f0647d6395c3d6611513cd24bc2419f::sfrogs {
    struct SFROGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFROGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFROGS>(arg0, 9, b"SFROGS", b"Frogs Sui", b"Frogssui is a memecoin built on the Sui ecosystem, inspired by the humor and popularity of frog memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fad62337-468c-4732-8d0d-bc6e92c091ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFROGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFROGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

