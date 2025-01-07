module 0xfda0bf8a9c86f4d4e33e4b8da4763e6348e69817603bbfcc96a4d9549ed816c::pako {
    struct PAKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAKO>(arg0, 6, b"PAKO", b"Pako the Limitless", b"Meet $PAKO, the penguin who cant stop dancing! Always on his flippers, this energetic little guy is here to add some fun and groove to the Sui Network. Waddle along with Pako!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_e1f760a234.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

