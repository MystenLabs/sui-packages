module 0x2d4c3006ef173fc50d28cc72c78e92edcde12a7af5e48dc2d299210a17612524::courage {
    struct COURAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COURAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COURAGE>(arg0, 6, b"COURAGE", b"COWARDLY COURAGE", x"496e737069726564206279207468652069636f6e696320636172746f6f6e206368617261637465722c20436f75726167652074686520436f776172646c7920446f672c207468697320696e6e6f7661746976652063727970746f63757272656e63792061696d7320746f20656d706f7765722069747320686f6c6465727320616e6420666f73746572206120737570706f72746976652c20616476656e7475726f7573207370697269742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/08276e1a_e2f6_4295_8cff_ee96d5a3cdfa_0e15490e23.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COURAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COURAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

