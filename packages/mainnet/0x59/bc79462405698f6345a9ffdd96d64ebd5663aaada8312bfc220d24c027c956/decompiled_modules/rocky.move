module 0x59bc79462405698f6345a9ffdd96d64ebd5663aaada8312bfc220d24c027c956::rocky {
    struct ROCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKY>(arg0, 9, b"Rocky", b"RockonSui", b"cutest rock on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/826904b244806de31bd215b61dd6a6aablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROCKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

