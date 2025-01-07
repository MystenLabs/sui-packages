module 0x4cbd4e551e28ebcfa29d10b8ea64929f7337090f256cbc63501646221c2ad9a6::dolpi {
    struct DOLPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPI>(arg0, 6, b"DOLPI", b"Dolpi on sui", b"Dopi is designed to create opportunities within the blockchain ecosystem. Our mission is to build a dynamic community where every member can interact, contribute, and grow together. We prioritize value growth and innovation, aiming to make Dopi a significant player in the Sui market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000044066_4366d3de34.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

