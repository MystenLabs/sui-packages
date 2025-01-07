module 0x1af5d3d2fd9d0f24f8056dc58e7e6a28c16a03c7b7b388f735be5d8fb1af5535::fuddies {
    struct FUDDIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDDIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDDIES>(arg0, 6, b"Fuddies", b"Fuddies on Turbos", b"Dev is dead", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956939376.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUDDIES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDDIES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

