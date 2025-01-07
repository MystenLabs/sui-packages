module 0x213435c6436e24b025530dfe9916fed6e1e198103cab44ae1c73de4dfd243f24::yga {
    struct YGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YGA>(arg0, 6, b"YGA", b"YELLOW GROUPER", x"424557415245205343414d45520a444f4e542042555920204a757374206a6f696e206f757220636f6d6d756e697479200a5745204c4f554e4348204146544552203530204d454d424552205447", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_11_27_at_23_08_12_c2d53b8c_7d637f2705.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

