module 0xe952f37565fb3dae24940ef702f765faf0fa08f7dcf6a30791383e2eda88cc34::snld {
    struct SNLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNLD>(arg0, 9, b"SNLD", b"Suinaldo", b"Meme coin token For Ronaldo Fans Boys", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e1aa7af-708e-4cff-861a-540d2f7bccb1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

