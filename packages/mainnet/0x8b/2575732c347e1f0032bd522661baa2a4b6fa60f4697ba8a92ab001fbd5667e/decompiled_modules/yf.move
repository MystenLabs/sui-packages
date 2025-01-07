module 0x8b2575732c347e1f0032bd522661baa2a4b6fa60f4697ba8a92ab001fbd5667e::yf {
    struct YF has drop {
        dummy_field: bool,
    }

    fun init(arg0: YF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YF>(arg0, 6, b"YF", b"TANTO MONTA", x"54616e746f204d6f6e7461202d204d6f6e74612054616e746f202d2049736162656c20636f6d6f204665726e616e646f0a54686120436174686f6c6963204b696e6773206f662043617374696c6520616e6420417261676f6e2031343932", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sin_t_A_tulo_2_c74f755701.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YF>>(v1);
    }

    // decompiled from Move bytecode v6
}

