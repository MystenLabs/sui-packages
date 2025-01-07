module 0x77b53f85f7cee604780d31c8a0070af78a719f67a91bfe35e4e518c824c8e660::tge {
    struct TGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGE>(arg0, 9, b"TGE", b"TGE?!?!", b"When TGE? Rally", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6b738065-a79f-4424-b1d0-2311797b416a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

