module 0xcdf4451325be89a4ae5d47ba96f823cf4b233acc56f43ff7ecb4c5fcb7275ca8::wel {
    struct WEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEL>(arg0, 6, b"WEL", b"Just a smol wel", b"smol wel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000060_f080e636de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

