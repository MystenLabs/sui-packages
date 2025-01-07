module 0xae90b8c1ba93b502a6c83d292a4c9f96d2f18dfb3af0a989f09727a46d785c4a::suirt {
    struct SUIRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRT>(arg0, 6, b"Suirt", b"Suirtle", x"53756972746c65206973206c616e64696e67206f6e2053756920746f206265636f6d6520746865206e756d626572206f6e65206d6173636f74210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0759_0c28da7a6e.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

