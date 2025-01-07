module 0x52515ebe25071f522b0ab56fb0f991d1dd990d9d3fdf218de1bcfbad09fac3b6::clam {
    struct CLAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAM>(arg0, 6, b"CLAM", b"Clam on Sui", b"A funny sea creature appears on the sui blockchain here to make friends and have fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://t4.ftcdn.net/jpg/03/50/16/51/360_F_350165182_uny24kPMK6GF2elm6CunlCQci9wH3Aco.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CLAM>(&mut v2, 15000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

