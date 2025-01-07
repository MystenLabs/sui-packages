module 0x5cae795f3d2aabb5fa701b95d3c2772d77a9a4a36f5c22d311790325d534c986::wifh {
    struct WIFH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFH>(arg0, 9, b"WIFH", b"DogWifHeir", b"Dog memes is great but people want DogWifHeir", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2060aaf8-10f3-410f-9644-81c33b882ec9-IMG_20241005_074246_839.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIFH>>(v1);
    }

    // decompiled from Move bytecode v6
}

