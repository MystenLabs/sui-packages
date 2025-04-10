module 0x9f1563f65d7674d753c0212788732eb02012e7da2613f5ae4d992e0883baae1d::mmsl {
    struct MMSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMSL>(arg0, 9, b"MMSL", b"MMSL token", b"my test token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/63829586ce886d3b7556bb55467a3142blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMSL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMSL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

