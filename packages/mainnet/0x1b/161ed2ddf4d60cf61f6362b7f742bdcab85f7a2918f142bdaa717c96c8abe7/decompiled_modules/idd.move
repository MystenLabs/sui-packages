module 0x1b161ed2ddf4d60cf61f6362b7f742bdcab85f7a2918f142bdaa717c96c8abe7::idd {
    struct IDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDD>(arg0, 6, b"IDD", b"I dont know how to dump", b"I'm making this coin because I don't even know how to dump on people.  I do remember two girls one cup when I was growing up. It was viral video for the time. Enter if you need to take a shit. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/49_F54_AD_0_6_BF_0_41_AD_991_B_57_D403_F208_BE_7b854f153e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

