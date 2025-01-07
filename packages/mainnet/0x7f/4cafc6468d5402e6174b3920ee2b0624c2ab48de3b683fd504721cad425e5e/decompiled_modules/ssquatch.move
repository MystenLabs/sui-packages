module 0x7f4cafc6468d5402e6174b3920ee2b0624c2ab48de3b683fd504721cad425e5e::ssquatch {
    struct SSQUATCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSQUATCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSQUATCH>(arg0, 6, b"SSQUATCH", b"SuiSquatch", x"546865204c6567656e64617279204d656d6520436f696e206f662074686520466f7265737420696e73706972656420627920746865206c6567656e64617279205361737175617463680a497473207468652063727970746f20776f726c647320616e7377657220746f2061206d656d652d696669656420666f72657374206c6567656e640a417320656c757369766520617320426967666f6f742068696d73656c662c207468697320636f696e2077696c6c2062652061742074686520666f726566726f6e74206f66206120626967666f6f742073697a6564206d6f76656d656e7420696e20746865206d656d6520636f696e206d61726b65742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_07_20_19_28_66b91fece7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSQUATCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSQUATCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

