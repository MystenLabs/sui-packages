module 0xe4b8965e097c1a85ee1feaf268cf7e61104cc992f457bf30f4ca4a27dff37481::brick {
    struct BRICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRICK>(arg0, 6, b"BRICK", b"BRICK ON SUI", b"Building an organic OG community  by . DYOR &  the blockchain. NFA & No affiliations b/c its just a meme. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Z5v_Dj2_Xd_400x400_67da3f799c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

