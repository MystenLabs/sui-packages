module 0x1bcd925b967bc18aa1dd9085ea16539deb06cf543cc830a459d314096f13a1f1::imr804 {
    struct IMR804 has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMR804, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMR804>(arg0, 9, b"IMR804", b"IMRAN804", b"IMRAN804 is a meme inspired by the spirit of adventure and freedom. with IMRAN804 we are not just riding the IMRAN804 we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e56777b6-5834-47b9-bc18-7d2f546e2ba4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMR804>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IMR804>>(v1);
    }

    // decompiled from Move bytecode v6
}

