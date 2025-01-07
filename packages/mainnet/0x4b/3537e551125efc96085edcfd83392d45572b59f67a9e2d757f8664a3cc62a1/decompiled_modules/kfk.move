module 0x4b3537e551125efc96085edcfd83392d45572b59f67a9e2d757f8664a3cc62a1::kfk {
    struct KFK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KFK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KFK>(arg0, 6, b"KFK", b"Kung Fu Kangaroo", x"4b756e676675204b616e6761726f6f3a20486f7070696e67204f6e746f0a53756920436861696e207769746820506f77657220616e6420507265636973696f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053600_290b7ae4f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KFK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KFK>>(v1);
    }

    // decompiled from Move bytecode v6
}

