module 0x827f0d842a8d9f40b3f42257a9a3288fc1b47667f96b21876744fba996396a13::bubl {
    struct BUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBL>(arg0, 6, b"BUBL", b" BUBL on Sui ", x"427562626c65732061726520666f756e642077686572657665722074686572652069732077617465722c20616e6420537569206973206e6f20646966666572656e742e20546865792070756d702c20666c6f61742c20616e6420626f696c20e28094207468657927726520656e6a6f7961626c652e205375692069732077617465722c20616e6420776174657220726571756972657320627562626c65732e20506c6179206f757220706c6f706572626f7420616e642067657420616e2065787472612064726f7021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731325307617.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

