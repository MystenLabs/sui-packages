module 0xebd69dddbab4c694c73751ebe7b76c408a1424295cbf480d6828b2942dd7bfce::cdh {
    struct CDH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CDH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CDH>(arg0, 9, b"CDH", b"cloud hear", b"cloud heart CUT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f23e5b3b-0bc2-40a9-9d4d-f59eceab51e3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CDH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CDH>>(v1);
    }

    // decompiled from Move bytecode v6
}

