module 0xc508ab4e4160c05b0acb75ce79deefa8f2618ff79f30fca11a4c1d7d94ea7805::bbwalcto {
    struct BBWALCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBWALCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBWALCTO>(arg0, 6, b"BBWalCTO", b"Baby Walrus CTO", b"Baby Walrus Community Take Over", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bwalccto_2f1309b6ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBWALCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBWALCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

