module 0x26b627551b4267decafb13c80e4e0eeab03abb906a5134430f1e9961b0cf85b0::tenx {
    struct TENX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TENX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TENX>(arg0, 6, b"TenX", b"10X Coin", b"Buy and hold,10X easy,We have no social, we only have faith,just do it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_a70a6c8846.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TENX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TENX>>(v1);
    }

    // decompiled from Move bytecode v6
}

