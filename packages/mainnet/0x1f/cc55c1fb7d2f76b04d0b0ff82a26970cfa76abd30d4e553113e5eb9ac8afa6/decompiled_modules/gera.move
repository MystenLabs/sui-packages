module 0x1fcc55c1fb7d2f76b04d0b0ff82a26970cfa76abd30d4e553113e5eb9ac8afa6::gera {
    struct GERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GERA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GERA>(arg0, 6, b"GERA", b"Gera coin", x"4745524120436f696e206973206d6f7265207468616e206a75737420612063727970746f63757272656e63792e20427920636f6d62696e696e672068756d6f722c206574686963616c207265646973747269627574696f6e2c20636f6d6d756e69747920656e676167656d656e742c20616e6420706f73697469766520696d706163742c20474552412061696d7320746f207472616e73666f726d207468652070657263657074696f6e206f66206d656d6520636f696e732e0a4a6f696e20757320696e206d616b696e672063727970746f206120746f6f6c20666f722067656e65726f736974792c206f6e6520646f6e6174696f6e20617420612074696d652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058335_314765c714.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GERA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GERA>>(v1);
    }

    // decompiled from Move bytecode v6
}

