module 0x520b6c58a1fdc2200fdd4a83b1f35fb27a3e1c35729bbdfd64570eb13132eb44::hopbunny {
    struct HOPBUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPBUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPBUNNY>(arg0, 6, b"HopBunny", b"HopBunnyonsui", b"HOP BUNNY THE FIRST BUNNY ON turbos.finance & suinetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731325125944.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPBUNNY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPBUNNY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

