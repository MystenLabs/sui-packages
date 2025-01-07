module 0x3f1ea82298b319bdd9d141d79c64ca2480b1fc0a2c7adac2b37f35f4000a73a1::sss {
    struct SSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSS>(arg0, 6, b"SSS", b"SuiSeaSpin", x"53756920536561205370696e20546f6b656e20746865206e6577207375692067656d207468617420636f6d62696e657320206d656d6520616e6420616e642066756e20746f206769766520612062756c6c6973682063727970746f20657870657269656e63652e2053756920736561207370696e206f666665727320207574696c697469657320737563682061732020706f6b657220616e642072657761726420746f20686f6c646572732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_09_04_34_33_d4499d6d9f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

