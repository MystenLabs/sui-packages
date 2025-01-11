module 0xdb398fc6324c22e42a68e869f6ae42415e3a3b7897d44167de16fab0cfa29c41::smap {
    struct SMAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMAP>(arg0, 6, b"SMAP", b"SUI Meme After Party", x"20526561647920666f722074686520756c74696d617465205375692070617274793f0a20537569204d656d65204166746572205061727479206973206272696e67696e6720746f67657468657220746865206d6f73742069636f6e6963206d656d6573206f662074686520537569206e6574776f726b20696e206f6e65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/smap_c042d205d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

