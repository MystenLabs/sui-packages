module 0xd60ec2d978bf5e2528e5b6ea66a20819eb4f3c16db1808f631034acc310d27ff::autoai {
    struct AUTOAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUTOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUTOAI>(arg0, 6, b"AUTOAI", b"Auto AI", b"Making business easier with smart AI.  Simple automation, better decisions, and great customer experiences. Community: https://t.me/AUTOAI.IO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/515_0699d52750.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUTOAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AUTOAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

