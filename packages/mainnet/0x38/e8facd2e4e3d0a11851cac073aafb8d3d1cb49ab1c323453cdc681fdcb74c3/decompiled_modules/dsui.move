module 0x38e8facd2e4e3d0a11851cac073aafb8d3d1cb49ab1c323453cdc681fdcb74c3::dsui {
    struct DSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSUI>(arg0, 6, b"DSUI", b"DinoSui", x"44696e6f537569204e465420697320676f696e6720746f2062652041697264726f70656420746f20616c6c20686f6c64657273207468617420686f6c642044696e6f73756920746f6b656e206f6e636520626f6e6465642c6a7573742062757920616e6420686f6c64202444535549200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1631_675e01b24b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

