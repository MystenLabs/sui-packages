module 0x599df0dc28a0dc8ae03611a6444ee674391a7d9a5daf3dda0be98b1c2d0bc7ad::eywa {
    struct EYWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYWA>(arg0, 9, b"EYWA", b"Eywa // 2408", b"This is Officials Community Token of Eywa // 2408", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e18e93ff355403ae3bd303812d786105blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EYWA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYWA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

