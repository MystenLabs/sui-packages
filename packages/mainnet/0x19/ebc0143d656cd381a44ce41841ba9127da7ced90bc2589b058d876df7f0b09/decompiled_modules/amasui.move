module 0x19ebc0143d656cd381a44ce41841ba9127da7ced90bc2589b058d876df7f0b09::amasui {
    struct AMASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMASUI>(arg0, 6, b"AMASUI", b"Amasui", b"$AMASUI The new and the hottest token in the cryptoverse.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1728516063913_2_5a416a6535.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

