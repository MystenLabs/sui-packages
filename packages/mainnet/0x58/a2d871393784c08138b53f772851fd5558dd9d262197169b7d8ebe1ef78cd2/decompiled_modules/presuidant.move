module 0x58a2d871393784c08138b53f772851fd5558dd9d262197169b7d8ebe1ef78cd2::presuidant {
    struct PRESUIDANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRESUIDANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRESUIDANT>(arg0, 6, b"PRESUIDANT", b"preSUIdant", x"7472456d7020697320612062456c6c696f6e41726975537768752077416e747320657645726920537569207573657220746f206245636f6d652061206d456c6c696f41726975532e2054686174277320776869206865206445636964656420746f2062452070726553756964614e742c20616c736f0a546f206465666974206f557220617243682d6e456d65736975532c206b614d616c69755320686f527269427573206f6620536f6c416e697553210a0a766f546520666f5265207472456d70210a0a616e442062756953202470724573554964416e5420666f7265207775696e206d456c6c69755320616e44206d456c6c6975532e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Estate_preparado_3e02dffff6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRESUIDANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRESUIDANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

