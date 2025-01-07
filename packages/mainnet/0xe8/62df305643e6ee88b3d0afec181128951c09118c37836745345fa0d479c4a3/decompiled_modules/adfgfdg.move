module 0xe862df305643e6ee88b3d0afec181128951c09118c37836745345fa0d479c4a3::adfgfdg {
    struct ADFGFDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADFGFDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADFGFDG>(arg0, 9, b"ADFGFDG", b"tretre", b"sdfsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1c6a5cc-5c1c-4143-a550-b84bb6e43a07.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADFGFDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADFGFDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

