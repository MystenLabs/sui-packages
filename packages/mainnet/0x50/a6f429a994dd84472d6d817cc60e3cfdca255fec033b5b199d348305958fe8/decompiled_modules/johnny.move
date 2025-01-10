module 0x50a6f429a994dd84472d6d817cc60e3cfdca255fec033b5b199d348305958fe8::johnny {
    struct JOHNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOHNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOHNNY>(arg0, 6, b"JOHNNY", b"Johnny Tsuinami", b"Gotta be quicker than that, buddy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/coinimage_387ae79119.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOHNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOHNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

