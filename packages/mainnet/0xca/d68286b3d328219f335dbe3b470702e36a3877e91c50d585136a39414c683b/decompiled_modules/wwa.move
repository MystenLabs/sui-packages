module 0xcad68286b3d328219f335dbe3b470702e36a3877e91c50d585136a39414c683b::wwa {
    struct WWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWA>(arg0, 9, b"WWA", b"Wood", b"Wood the best meme ever ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ff50b8d2-e2b8-4466-9da3-9c2738dffeeb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

