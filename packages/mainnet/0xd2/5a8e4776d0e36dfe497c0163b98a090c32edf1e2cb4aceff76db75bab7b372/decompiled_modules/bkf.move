module 0xd25a8e4776d0e36dfe497c0163b98a090c32edf1e2cb4aceff76db75bab7b372::bkf {
    struct BKF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKF>(arg0, 9, b"BKF", b"breakfast", b"Blast off with AstroCoin: The cosmic meme currency that's out of this world, bringing stellar laughs and intergalactic gains to the crypto universe!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f33c99a-010f-4a1b-86a7-ea91a679fa55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BKF>>(v1);
    }

    // decompiled from Move bytecode v6
}

