module 0x180c3d44a802cb3c7cf29f4a3feb9196e5077438dfc18104d54b42b59501a735::ap {
    struct AP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AP>(arg0, 9, b"AP", b"Apunk", b"Punk Hair Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/44b1ecec-9365-4c92-8c34-912201484415.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AP>>(v1);
    }

    // decompiled from Move bytecode v6
}

