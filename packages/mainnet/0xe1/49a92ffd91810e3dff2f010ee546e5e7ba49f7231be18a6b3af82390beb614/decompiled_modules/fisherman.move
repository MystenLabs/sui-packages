module 0xe149a92ffd91810e3dff2f010ee546e5e7ba49f7231be18a6b3af82390beb614::fisherman {
    struct FISHERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHERMAN>(arg0, 6, b"FISHERMAN", b"Just a chill fisherman", x"41206669736865726d616e207769746820616e20616d626974696f6e206f66206361746368696e67207768616c6573206f6e204d4f564550554d500a0a4f6e636520616761696e20616e6420616761696e20746f2072656d696e642c206f7572207469636b657220697320234649534845524d414e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_W9_QMZ_400x400_5d6f419df7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHERMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHERMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

