module 0x8319738d7936e2d197828c60e22aa3f7320bc8c9e9a97a954ba4dd5d8d78d648::suiky {
    struct SUIKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKY>(arg0, 6, b"SUIKY", b"SUIKY ", x"477265617421204c657427732077656c636f6d652065766572796f6e6520746f2074686520245355494b59202e6d656d652067726f7570206f6e20537569206e6574776f726b2120546869732077696c6c2062652077686572652077652073686172652066756e6e79206d656d65732c2075706461746520746865206c6174657374206e6577732061626f75742053756920616e6420636f6e6e65637420776974682074686520636f6d6d756e697479206f6620537569206c6f766572732e0d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735992866344.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

