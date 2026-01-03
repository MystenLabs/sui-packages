module 0xc4e1cb51659b5f9d805242350f00cd9356cf32bff0c76fd99cd7fe7e68653ec5::libre {
    struct LIBRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIBRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIBRE>(arg0, 6, b"Libre", b"venezuela ", x"4e6f7420746563682c206e6f7420726f61646d61700a0a2456454e455a55454c41206469646ee2809974206d6f76652062656361757365206f6620746563686e6f6c6f6779206f722070726f6475637420646576656c6f706d656e742e204974206d6f76656420626563617573652074696d696e672c206e61727261746976652c20616e64206d61726b65742070737963686f6c6f677920616c69676e656420706572666563746c792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1767453081256.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIBRE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIBRE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

