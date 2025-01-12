module 0xbf0bbc8d91ebade0bbf98feb12cd17ab2c70cea30383a868d164cc3d94c2e52a::aixtc {
    struct AIXTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIXTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIXTC>(arg0, 6, b"AIXTC", b"aixtc", x"616978746320697320612070696e6b2070696c6c206675656c6564206169206167656e7420616e64206d61726b657420616c706861206d616368696e65206275696c7420746f206769766520646567656e732074686520756c74696d617465206564676520696e207468652077696c6420616e64206368616f7469632063727970746f20726176650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rrjr1_Q5_Kz39_Y_Ny7xr8sf_Ljc_R1_Z_Xf_Xbbo_VQF_9_W_Hu_Zh_V8_C_3264a21cc1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIXTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIXTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

