module 0xe1d140fc5f5e3fb6d0e95c493c95f177a61e6d704fd85753361ee169a57db59c::ksune {
    struct KSUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSUNE>(arg0, 6, b"KSUNE", b"Kitsunecoin", x"476f6f64204d6f726e696e67204b697473756e652046616d210a0a0a0a476f6f6420206d6f726e696e6721204d617920796f7572206461792062652061732063756e6e696e6720616e64206d61676963616c20617320746865204b495453554e452077656176696e67207468726f75676820616e6369656e7420666f72657374732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036259_840b772510.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSUNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KSUNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

