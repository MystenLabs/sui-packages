module 0xf9930bf883298f61fe3c6a3dfab43e9fa5ca8217447d99f83bde6dbdc773db9f::suiwars {
    struct SUIWARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWARS>(arg0, 6, b"SUIWARS", b"Sui Star Wars", b"May The Force Be With You On Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiwarsprof_24cfee212d.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

