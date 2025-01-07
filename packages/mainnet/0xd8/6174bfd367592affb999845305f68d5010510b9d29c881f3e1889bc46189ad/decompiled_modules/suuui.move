module 0xd86174bfd367592affb999845305f68d5010510b9d29c881f3e1889bc46189ad::suuui {
    struct SUUUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUUUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUUUI>(arg0, 6, b"SUUUI", b"suuui", x"54686520466972737420435237204d656d65636f696e206f6e205355490a235355555549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sans_titre_2e9726542d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUUUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUUUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

