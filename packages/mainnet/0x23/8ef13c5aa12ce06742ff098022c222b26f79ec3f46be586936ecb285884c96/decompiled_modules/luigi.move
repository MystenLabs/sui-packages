module 0x238ef13c5aa12ce06742ff098022c222b26f79ec3f46be586936ecb285884c96::luigi {
    struct LUIGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUIGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUIGI>(arg0, 6, b"Luigi", b"Luigi Mangione", b"Person of Interest in a Fatal Shooting ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055380_7e9ba2109e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUIGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUIGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

