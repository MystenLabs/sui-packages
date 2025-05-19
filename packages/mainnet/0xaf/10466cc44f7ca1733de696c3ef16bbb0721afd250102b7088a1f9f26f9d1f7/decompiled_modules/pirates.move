module 0xaf10466cc44f7ca1733de696c3ef16bbb0721afd250102b7088a1f9f26f9d1f7::pirates {
    struct PIRATES has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRATES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRATES>(arg0, 6, b"PIRATES", b"King Pirates", x"43727970746f20576f726c6420547265617375726573210a0a4a6f696e20616e206570696320616476656e7475726520696e2074686520626c6f636b636861696e20776f726c642077697468204b696e6720506972617465732061206469676974616c20617373657420696e7370697265642062792074686520737069726974206f66206c6567656e6461727920706972617465732077686f207361696c656420666f722066726565646f6d2c20706f77657220616e6420756e6c696d6974656420747265617375726521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiedtcvd3hfsnmzprxwlavy6urkgyprjuuv5kwuq2iopnwvpxb5vby")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRATES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIRATES>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

