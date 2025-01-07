module 0xb71ab89f0a2d15661325d70a722c5fad1f270a23339c5a6a18ede13da3a42b8a::hdogs1 {
    struct HDOGS1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDOGS1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDOGS1>(arg0, 9, b"HDOGS1", b"HappyDogs", b"Friendly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/de5c20de-ea02-4b17-a936-9da1e37483e7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDOGS1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HDOGS1>>(v1);
    }

    // decompiled from Move bytecode v6
}

