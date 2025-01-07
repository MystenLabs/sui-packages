module 0x44fe92b00b2d9b317a68a438ad8695513f72244952a716b4024012e2027c2632::nibbler {
    struct NIBBLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIBBLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIBBLER>(arg0, 6, b"NIBBLER", b"LORD NIBBLER", b"Lord Nibbler is a Nibblonian who has existed since the beginning of time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241010_211054_917_548636accf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIBBLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIBBLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

