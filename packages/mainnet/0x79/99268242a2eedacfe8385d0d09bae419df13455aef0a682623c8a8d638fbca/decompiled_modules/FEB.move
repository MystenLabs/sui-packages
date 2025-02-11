module 0x7999268242a2eedacfe8385d0d09bae419df13455aef0a682623c8a8d638fbca::FEB {
    struct FEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEB>(arg0, 9, b"FEB", b"FEB", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FEB>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FEB>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<FEB>>(0x2::coin::mint<FEB>(&mut v2, 1100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

