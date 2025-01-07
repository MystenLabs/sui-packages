module 0x294d1b4cc9c8a54c482b3d8cac905eec9b69adceebb411d65459227a22bbc02::coolx {
    struct COOLX has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOLX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOLX>(arg0, 9, b"COOLX", b"Cool", b"Cool Elon musk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1d8ef867-447e-4669-9de7-2dd971bdd83b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOLX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COOLX>>(v1);
    }

    // decompiled from Move bytecode v6
}

