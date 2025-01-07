module 0x5c1b850b02fb0c3122cd2bb27fcb641e8bfe4764706feeb0535aa61402d4199d::sprunki {
    struct SPRUNKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRUNKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPRUNKI>(arg0, 6, b"SPRUNKI", b"Sprunki On Sui", x"74277320616e20617765736f6d65206d757369632067616d6520776865726520796f752063616e206d697820646966666572656e7420736f756e647320746f2063726561746520796f7572206f776e20736f6e67732e20537072756e6b692069732073757065722066756e20616e64206561737920746f20757365202d206576656e206b6964732063616e206d616b6520616d617a696e67206d7573696320776974682069742120506c617920537072756e6b69206e6f772061742057686174204d616b657320537072756e6b69205370656369616c3f204561737920746f20506c6179204a75737420636c69636b20616e64206472616720746f2e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049080_a01cb2a2a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPRUNKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPRUNKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

