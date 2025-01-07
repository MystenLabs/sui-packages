module 0x1827c2e46227ce3feb08f5e514fede7cd49767fc2f8502a29b43bf76559688f1::pepedeng {
    struct PEPEDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEDENG>(arg0, 6, b"PEPEDENG", b"Pepe Deng", x"537465702072696768742075702c20666f6c6b732c20616e6420666561737420796f75722065796573206f6e20746865206f6e6520616e64206f6e6c7920506570652044656e67212048616c6620506570652c2068616c66204d6f6f44656e670a0a68747470733a2f2f742e6d652f5065706544656e6745524332300a68747470733a2f2f782e636f6d2f5065706544656e67436f696e0a68747470733a2f2f5065706544656e672e73697465", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241010_010917_037_b77cfeef56.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

