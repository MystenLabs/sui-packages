module 0x6ae865279ab577583a5a1aa3d7f253b9a4d9e296ced1212449a543a3bc1d6279::suisunggly {
    struct SUISUNGGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISUNGGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISUNGGLY>(arg0, 6, b"SUISUNGGLY", b"SUISUNG GALAXY", b"We just got Suisung-ed!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O2c_R_Qv4p_400x400_6aa9a21606.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISUNGGLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISUNGGLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

