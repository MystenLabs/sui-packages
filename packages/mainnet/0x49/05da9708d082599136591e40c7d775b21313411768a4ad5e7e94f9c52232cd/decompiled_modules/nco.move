module 0x4905da9708d082599136591e40c7d775b21313411768a4ad5e7e94f9c52232cd::nco {
    struct NCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NCO>(arg0, 9, b"NCO", b"Nani co", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b82cd81-0c65-48f4-94a9-8aa5001e0229.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

