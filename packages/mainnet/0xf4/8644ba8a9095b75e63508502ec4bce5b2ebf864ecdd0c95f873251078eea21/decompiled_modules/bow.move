module 0xf48644ba8a9095b75e63508502ec4bce5b2ebf864ecdd0c95f873251078eea21::bow {
    struct BOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOW>(arg0, 6, b"BOW", b"Rainbow Blastoid", x"0a24486f70707920244472616767792024666566652024706570652024616e64792024776f6c66202467726f67676f20246f686172652024666c7566667920246d6174742024736b756c6c2024776174", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZSH_49_Gbo_A_Ajua4_a1acc7ca88.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

