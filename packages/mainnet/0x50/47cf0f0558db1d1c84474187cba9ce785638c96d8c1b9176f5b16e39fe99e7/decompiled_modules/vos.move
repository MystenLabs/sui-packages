module 0x5047cf0f0558db1d1c84474187cba9ce785638c96d8c1b9176f5b16e39fe99e7::vos {
    struct VOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOS>(arg0, 4, b"VOS", b"VineOnSui", b"VineOnSui Official", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/1ebc2820-d985-11ef-80e8-811f7f414973")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOS>>(v1);
        0x2::coin::mint_and_transfer<VOS>(&mut v2, 11000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

