module 0xd618c98f711f1f15a3ad9363e891f1317614d796e96d39a63edce7205f46dde7::jbg {
    struct JBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JBG>(arg0, 9, b"JBG", b"Lion", b"For the community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f26cb3c4-7f49-4d7a-ae03-3328e4370e10.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JBG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JBG>>(v1);
    }

    // decompiled from Move bytecode v6
}

