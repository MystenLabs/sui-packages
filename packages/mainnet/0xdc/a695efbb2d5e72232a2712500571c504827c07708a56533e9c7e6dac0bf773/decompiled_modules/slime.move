module 0xdca695efbb2d5e72232a2712500571c504827c07708a56533e9c7e6dac0bf773::slime {
    struct SLIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIME>(arg0, 6, b"SLIME", b"SUI Slime", x"5468652065766f6c76696e6720534c494d4520626f756e636573206f6e207468652053554920636861696e0a0a3130302520434f4d4d554e495459204f574e4544207c20434330", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rimuru_tempest_17593_1e2778adf7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

