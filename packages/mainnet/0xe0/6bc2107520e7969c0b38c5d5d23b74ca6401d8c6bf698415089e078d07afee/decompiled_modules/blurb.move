module 0xe06bc2107520e7969c0b38c5d5d23b74ca6401d8c6bf698415089e078d07afee::blurb {
    struct BLURB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLURB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLURB>(arg0, 6, b"BLURB", b"Blurb", b"BLURB is the NERD Fish on SUI!!! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732798336914.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLURB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLURB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

