module 0x979de0633e47fc10407fbe6fa3b80e0ebe50e25726a62a2cbabce7eda6589a8d::dynasty {
    struct DYNASTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DYNASTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DYNASTY>(arg0, 6, b"Dynasty", b"Sui Dynasty", x"496620796f7520756e6465727374616e6420686973746f727920796f752077696c6c206b6e6f7720776861742074686973206973206966206e6f7420776f726b206974206f75742e200a0a466f72205375692074686973206e61727261746976652069732061206669727374206d6f7665722e0a0a427579206974206f72206e6f7420692077696c6c206d616b65207375726520697420626f6e6473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2970a294027694014a3e3f1131c4fdd8_4fac581114.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DYNASTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DYNASTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

