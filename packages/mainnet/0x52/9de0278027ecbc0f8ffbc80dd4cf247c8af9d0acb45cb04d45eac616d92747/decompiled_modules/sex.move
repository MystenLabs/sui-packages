module 0x529de0278027ecbc0f8ffbc80dd4cf247c8af9d0acb45cb04d45eac616d92747::sex {
    struct SEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEX>(arg0, 6, b"SEX", b"SEX ON SUI", b"Anyone who held this coin could feel their power and passion, making it the most coveted currency in the cryptocurrency world. Website: https://sexonsui.xyz/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_20_e69f47016b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

