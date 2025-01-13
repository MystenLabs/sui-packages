module 0x524876c708b8f3049b048cb95bbb8c77c86e67beab5afd5198b029964e3e821b::jersey {
    struct JERSEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JERSEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JERSEY>(arg0, 6, b"JERSEY", b"Jersey Sui", x"4a75737420636c69636b2c2063686f6f736520796f757220736964653a20416e67656c20206f722044656d6f6e202e0a54686520726163652068617320626567756e77686f2077696c6c20726569676e2073757072656d65203f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul79_20250111215613_fb97211bda.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JERSEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JERSEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

