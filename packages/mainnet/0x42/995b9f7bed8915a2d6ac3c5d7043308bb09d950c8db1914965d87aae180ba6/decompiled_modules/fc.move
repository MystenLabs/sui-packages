module 0x42995b9f7bed8915a2d6ac3c5d7043308bb09d950c8db1914965d87aae180ba6::fc {
    struct FC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FC>(arg0, 6, b"FC", b"Fire Cracker", b"Watch us blow some sh*t up. No one can stop us!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Flame_f7fec23b6c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FC>>(v1);
    }

    // decompiled from Move bytecode v6
}

