module 0x5e41a0153360983d5d100a9f2b1073b7c6ae17ff5ffa730423d886e164d555c::sumoon {
    struct SUMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMOON>(arg0, 6, b"SUmoon", b"SUMOON", x"5468652053756d6f6f6e20697320746865206f6666696369616c20746f6b656e206f662053754d6f6f6e20626f742e2049742077696c6c206265207573656420666f7220696e626f74207472616e73616374696f6e732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/istockphoto_157286040_612x612_ef1a11dab2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

