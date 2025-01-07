module 0x30665de700e3cc0a06045d8026497304562abdc05d863cb62862b52d99a4f6e6::mds {
    struct MDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDS>(arg0, 6, b"MDS", b"mondosui", b"\"/d\"  \"/d,\" #SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OGKL_3p_XD_400x400_948d5381dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

