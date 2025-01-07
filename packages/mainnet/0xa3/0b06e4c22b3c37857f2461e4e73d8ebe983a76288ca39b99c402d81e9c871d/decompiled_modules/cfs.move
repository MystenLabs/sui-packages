module 0xa30b06e4c22b3c37857f2461e4e73d8ebe983a76288ca39b99c402d81e9c871d::cfs {
    struct CFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFS>(arg0, 9, b"CFS", b"Coffee spo", b"coffee and a spoon, are you ready?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/74434966-a7e7-4c3f-af7a-71a55b006e5e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

