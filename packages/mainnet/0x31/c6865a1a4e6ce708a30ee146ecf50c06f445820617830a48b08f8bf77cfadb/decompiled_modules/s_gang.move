module 0x31c6865a1a4e6ce708a30ee146ecf50c06f445820617830a48b08f8bf77cfadb::s_gang {
    struct S_GANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: S_GANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S_GANG>(arg0, 9, b"S_GANG", b"SUIGANG", b"Swangang is a meme token with the mission that, for every transaction made, a percentage goes towards supporting internally displaced persons. It is inspired by the the zeal to become filled with wisdom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0d80e257-0bb5-4902-b2f2-4333e8939e5f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S_GANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<S_GANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

