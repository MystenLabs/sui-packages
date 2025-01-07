module 0x3df8ea6b9563e4f08d2f6fe2c2afa0b29e449098a8990f24e51e2ef1fb6830b1::necia {
    struct NECIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NECIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NECIA>(arg0, 9, b"NECIA", b"Necia", b"Sui night girl Necia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/694/616/large/maria-dimova-necia-fin.jpg?1728289812")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NECIA>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NECIA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NECIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

