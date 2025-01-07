module 0x2889d93abed05a9b08a1994de059c106235a881f0d504ecaf8058d3bc4e8d37::skyrupcat {
    struct SKYRUPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKYRUPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKYRUPCAT>(arg0, 9, b"SKYRUPCAT", b"SKYRUP", b"Skyrup is a meme inspired by the spirit of adventure and freedom. With syrup, we are not just riding the wave, we are mastering them.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9f770b94-777e-47e1-914a-f8c1942626f1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKYRUPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKYRUPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

