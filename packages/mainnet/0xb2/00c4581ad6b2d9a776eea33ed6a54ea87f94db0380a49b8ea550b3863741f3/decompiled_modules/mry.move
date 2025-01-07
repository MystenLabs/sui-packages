module 0xb200c4581ad6b2d9a776eea33ed6a54ea87f94db0380a49b8ea550b3863741f3::mry {
    struct MRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRY>(arg0, 9, b"MRY", b"miroh ya", b"bibik", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5e6ed94b-3216-4bb7-8a71-c86c3e7181a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

