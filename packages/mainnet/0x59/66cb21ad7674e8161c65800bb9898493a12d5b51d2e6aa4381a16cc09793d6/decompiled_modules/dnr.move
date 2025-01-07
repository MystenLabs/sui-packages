module 0x5966cb21ad7674e8161c65800bb9898493a12d5b51d2e6aa4381a16cc09793d6::dnr {
    struct DNR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNR>(arg0, 9, b"DNR", b"Dinar", b"This is meme coin lets make enjoy your money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/17528c62-412d-46eb-b032-98b837117fa3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DNR>>(v1);
    }

    // decompiled from Move bytecode v6
}

