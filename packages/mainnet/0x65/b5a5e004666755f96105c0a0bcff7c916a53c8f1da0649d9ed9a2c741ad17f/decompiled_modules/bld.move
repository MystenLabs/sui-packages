module 0x65b5a5e004666755f96105c0a0bcff7c916a53c8f1da0649d9ed9a2c741ad17f::bld {
    struct BLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLD>(arg0, 9, b"BLD", b"Blind", b"Blind Kahn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/340a173e728f5a786c3a358c2c690e62blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

