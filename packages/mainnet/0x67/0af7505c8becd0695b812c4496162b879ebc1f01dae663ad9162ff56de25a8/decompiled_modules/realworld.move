module 0x670af7505c8becd0695b812c4496162b879ebc1f01dae663ad9162ff56de25a8::realworld {
    struct REALWORLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: REALWORLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REALWORLD>(arg0, 9, b"REALWORLD", b"RNT", b"Real World Gold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0d6ea3a5-59d8-4f81-a55c-cd3bbb926e6d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REALWORLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REALWORLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

