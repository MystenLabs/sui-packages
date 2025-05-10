module 0x8463c24690de2984440f242e39323bd19837f0f7178675fb008ee016da82d92::kcrab {
    struct KCRAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KCRAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KCRAB>(arg0, 6, b"KCRAB", b"King Crab", b"Its King Crab season, this time you don't have to go out to the Bering Sea to get them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicmdso2dfhcsl5jtqzwhvmhrtkanu767rnscge3pumhuughfurtni")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KCRAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KCRAB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

