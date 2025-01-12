module 0x2af2c3737c402a3fab6a5394d23c1a4f123983eb2bc04bc1f967add338cc93d3::uni {
    struct UNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNI>(arg0, 6, b"UNI", b"Uniswap", b"uniswap meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/1130adaa-2924-4df7-89da-7181c1427774.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

