module 0xecbc99abb53bb26326f38a9c7c48e1b2326cee29264397a2f04f0e38c07ecb01::skyrupcat {
    struct SKYRUPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKYRUPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKYRUPCAT>(arg0, 9, b"SKYRUPCAT", b"SKYRUP", b"Skyrup is a meme inspired by the spirit of adventure and freedom. With syrup, we are not just riding the wave, we are mastering them.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f9d10a41-42b9-4968-ac76-cf3cbf181418.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKYRUPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKYRUPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

