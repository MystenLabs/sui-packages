module 0x3f7d955b7edb082767dc974947f7cb24a5411c6c9e5924096c1cb2700c417182::fre {
    struct FRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRE>(arg0, 9, b"FRE", b"Free", b"Freee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b3178d27-281e-4005-aa82-6fe16b4fed1c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

