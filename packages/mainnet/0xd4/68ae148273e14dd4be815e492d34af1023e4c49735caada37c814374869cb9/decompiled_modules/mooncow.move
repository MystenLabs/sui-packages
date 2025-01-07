module 0xd468ae148273e14dd4be815e492d34af1023e4c49735caada37c814374869cb9::mooncow {
    struct MOONCOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONCOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONCOW>(arg0, 6, b"MOONCOW", b"COWONMOON", b"a simple cow on the moon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6c84bde9d2aa1f5d4bb013d647f6cef6_a9fdc1e074.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONCOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONCOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

