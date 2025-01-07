module 0xe35659ae6741c78ab97bb4a3b2196f250f3163d9df0ab990fe389ced1564fbc5::rvr {
    struct RVR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RVR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RVR>(arg0, 9, b"RVR", b"River ", b"This is a meme token coined from a flowing river.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b5e690d1-7017-4239-92e6-5c58e522d6aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RVR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RVR>>(v1);
    }

    // decompiled from Move bytecode v6
}

