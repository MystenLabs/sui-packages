module 0x5a6cb4ea73666fd4ca04b177df0f9f19d6bfb2281cc931bd611397f778fd5577::yf {
    struct YF has drop {
        dummy_field: bool,
    }

    fun init(arg0: YF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YF>(arg0, 6, b"YF", b"TANTO MONTA", x"54414e544f204d4f4e5441202d204d4f4e54412054414e544f202d2049534142454c20434f4d4f204645524e414e444f2e0a54686520436174686f6c6963204b696e6773206f662043617374696c6520616e6420417261676f6e2031343932", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sin_t_A_tulo_2_84a155cfbd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YF>>(v1);
    }

    // decompiled from Move bytecode v6
}

