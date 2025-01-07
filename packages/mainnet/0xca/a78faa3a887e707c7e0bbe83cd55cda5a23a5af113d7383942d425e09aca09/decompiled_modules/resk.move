module 0xcaa78faa3a887e707c7e0bbe83cd55cda5a23a5af113d7383942d425e09aca09::resk {
    struct RESK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RESK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RESK>(arg0, 9, b"RESK", b"Reddit ", x"5765726565204920646f6ee2809974206b6e6f7720686f7720", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d7c5919-803b-4f71-be3a-c6fdd367254c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RESK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RESK>>(v1);
    }

    // decompiled from Move bytecode v6
}

