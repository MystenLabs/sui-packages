module 0x65319b687ed0d817fdf5e63931049420aa0eb22e258c7f42998d0a9deac24c38::seadog {
    struct SEADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEADOG>(arg0, 6, b"SEADOG", b"SeadogOnSui", b"$SEADOG - King of the high seas in the sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241009_022501_51b852c588.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEADOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

