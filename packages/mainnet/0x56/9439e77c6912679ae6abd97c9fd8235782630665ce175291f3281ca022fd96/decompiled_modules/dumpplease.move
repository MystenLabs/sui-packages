module 0x569439e77c6912679ae6abd97c9fd8235782630665ce175291f3281ca022fd96::dumpplease {
    struct DUMPPLEASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMPPLEASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMPPLEASE>(arg0, 9, b"DUMPPLEASE", b"PleaseDump", b"Hehe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1fdd70f-6a55-45a2-9270-1779e00926f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMPPLEASE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUMPPLEASE>>(v1);
    }

    // decompiled from Move bytecode v6
}

