module 0x55d5b4959e1252b8e701aee97804968cc8f1714b2c21d7b7fd53c0125cc497de::suisauce {
    struct SUISAUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISAUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISAUCE>(arg0, 6, b"SUISAUCE", x"737569f09f92a77361756365", x"537069636520757020796f757220706f7274666f6c696f207769746820746865207065726665637420626c656e64206f66206d616769632e0a0a537569205361756365206973207468652073656372657420f09f92a720796f75206e6565642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736294054142.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISAUCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISAUCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

