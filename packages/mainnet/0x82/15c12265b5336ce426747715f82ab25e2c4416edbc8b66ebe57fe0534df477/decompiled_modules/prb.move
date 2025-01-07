module 0x8215c12265b5336ce426747715f82ab25e2c4416edbc8b66ebe57fe0534df477::prb {
    struct PRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRB>(arg0, 6, b"PRB", b"PRABOWO", b"Jenderal TNI (HOR) (Purn.) Datuk Seri H. Prabowo Subianto Djojohadikusumo (EYD: Prabowo Subianto Joyohadikusumo; lahir 17 Oktober 1951) adalah seorang politikus, pengusaha dan pensiunan jenderal kehormatan tentara yang merupakan Presiden terpilih Indonesia dan Menteri Pertahanan.[1] Prabowo akan menjadi presiden ketiga Indonesia yang berlatar belakang militer setelah Soeharto dan Susilo Bambang Yudhoyono.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1002579162_07584fb051.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

