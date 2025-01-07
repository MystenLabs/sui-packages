module 0x840c34b900deb119fb4268bb6cd47d7a66d6bf04e15b45806d80b4d3b46c7746::toe {
    struct TOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOE>(arg0, 9, b"TOE", b"Dhit", b"Fot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/40449be4-663c-4800-bc6b-dd2fc8d933ad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOE>>(v1);
    }

    // decompiled from Move bytecode v6
}

