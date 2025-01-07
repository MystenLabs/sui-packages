module 0x38b59ace0e3066041932b8ec3727e6fcce36ec2f9883facf6f53ca86ea4ac05::kaeru {
    struct KAERU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAERU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAERU>(arg0, 6, b"KAERU", b"Kaeru On Sol", x"47657420726561647920666f72207468652072697365206f66204b616572752d73616d612c20746865206d69676874792066726f672073616d757261692077686f206973206865726520746f20636f6e717565722074686520776f726c64206f66206d656d6520636f696e73210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/y_WNUH_Wf1_400x400_9a84db97e2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAERU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAERU>>(v1);
    }

    // decompiled from Move bytecode v6
}

