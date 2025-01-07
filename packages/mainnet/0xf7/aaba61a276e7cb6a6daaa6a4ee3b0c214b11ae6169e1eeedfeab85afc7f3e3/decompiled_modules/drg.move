module 0xf7aaba61a276e7cb6a6daaa6a4ee3b0c214b11ae6169e1eeedfeab85afc7f3e3::drg {
    struct DRG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRG>(arg0, 9, b"DRG", b"Dragon", b"A community base meme token dedicated to the mythical creature of fire ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b754f2a8-f8e7-4fc9-8421-3422f8af79ad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRG>>(v1);
    }

    // decompiled from Move bytecode v6
}

