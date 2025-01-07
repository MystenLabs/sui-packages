module 0x1954c818c9326738acd877e6887a9574740d663abd3794f25575f26ff5658e58::gm {
    struct GM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GM>(arg0, 6, b"GM", b"Gud Mornin", x"5065706520686173206265656e206c6f76696e67206869732074696d652077697468206672656e732c207475726e696e67206576657279206d6f726e696e6720696e746f2061207472756c7920677564206d6f726e696e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b3l_Z_2io_400x400_49f1926152.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GM>>(v1);
    }

    // decompiled from Move bytecode v6
}

