module 0x2a968c69ea769e652499a182387b26daa286284f8e17b6edd7d8722f16c06259::fk {
    struct FK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FK>(arg0, 9, b"FK", b"FARMER KUR", b"An incredible meme on sui blockchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f7a87f9e-3262-4dd4-92da-0ca76ffea092.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FK>>(v1);
    }

    // decompiled from Move bytecode v6
}

