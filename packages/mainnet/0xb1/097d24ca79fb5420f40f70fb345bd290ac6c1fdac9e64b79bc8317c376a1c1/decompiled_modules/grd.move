module 0xb1097d24ca79fb5420f40f70fb345bd290ac6c1fdac9e64b79bc8317c376a1c1::grd {
    struct GRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRD>(arg0, 9, b"GRD", b"Green Dild", x"477265656e2044696c646f20436f696e3a20546865206f6e6c792063727970746f2077686572652065766572796f6e652077616e747320746f2073656520677265656e2064696c646f73206f6e207468656972206368617274732e2041207472696275746520746f2074686f736520676c6f72696f757320677265656e2063616e646c65732074686174206c6967687420757020796f75722074726164696e672073637265656e2e2050756d702069742c20686f6c642069742c20616e642077617463682074686520677265656e20726973652120f09f8cb1f09f93882023477265656e44696c646f202343727970746f4d656d65732023546f5468654d6f6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/654ad005-f873-45c0-bf07-f2e148178b0c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

