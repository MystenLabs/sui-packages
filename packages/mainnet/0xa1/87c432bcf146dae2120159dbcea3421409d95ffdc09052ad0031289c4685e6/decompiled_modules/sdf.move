module 0xa187c432bcf146dae2120159dbcea3421409d95ffdc09052ad0031289c4685e6::sdf {
    struct SDF has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SDF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SDF>>(0x2::coin::mint<SDF>(arg0, arg1 * 1000000000, arg3), arg2);
    }

    fun init(arg0: SDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDF>(arg0, 9, b"SDF", b"asdfadsf", b"asdfadsf token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://plz.money/coin-icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SDF>>(0x2::coin::mint<SDF>(&mut v2, 1 * 1000000000 / 100 * 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDF>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

