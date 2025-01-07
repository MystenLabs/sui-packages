module 0xa821c1777f37187361fa8e181e433025f826c29254bd2bc91dace09105e6fca2::sb {
    struct SB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SB>(arg0, 9, b"SB", b"SUIBASE", b"Suibase  , The Gateway to mars by  SuiX Aerospace , Founded by  MYSTEN LABS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7c44f3f9b1b07ad1f6423190867e5ca8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

