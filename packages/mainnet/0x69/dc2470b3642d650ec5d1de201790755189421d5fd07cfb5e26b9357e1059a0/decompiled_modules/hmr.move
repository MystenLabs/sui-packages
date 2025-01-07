module 0x69dc2470b3642d650ec5d1de201790755189421d5fd07cfb5e26b9357e1059a0::hmr {
    struct HMR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMR>(arg0, 9, b"HMR", b"homer", b"simpson", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/39e3344ce10ec427f48c5656fb5b7723blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HMR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

