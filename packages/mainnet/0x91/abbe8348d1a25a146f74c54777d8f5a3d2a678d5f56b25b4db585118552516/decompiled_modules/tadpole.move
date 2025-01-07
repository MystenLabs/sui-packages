module 0x91abbe8348d1a25a146f74c54777d8f5a3d2a678d5f56b25b4db585118552516::tadpole {
    struct TADPOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TADPOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TADPOLE>(arg0, 6, b"Tadpole", b"tadpole", x"45766572792024544144504f4c452067726f777320696e746f20245045504520202020200a0a53756920746f6b656e207363616e6e696e6720726f626f743a2068747470733a2f2f742e6d652f537569546164426f7420686173206265656e206c61756e63686564", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240925223811_e0a1c7e022.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TADPOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TADPOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

