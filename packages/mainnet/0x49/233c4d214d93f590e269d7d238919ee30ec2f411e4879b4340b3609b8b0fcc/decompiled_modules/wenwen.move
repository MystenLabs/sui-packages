module 0x49233c4d214d93f590e269d7d238919ee30ec2f411e4879b4340b3609b8b0fcc::wenwen {
    struct WENWEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WENWEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WENWEN>(arg0, 6, b"WenWen", b"Wen Moon Coin", x"57656e4d6f6f6e20436f696e2028535549204e6574776f726b290a57656e4d6f6f6e2069732061206d656d6520636f696e206f6e207468652053756920626c6f636b636861696e2c2073796d626f6c697a696e672074686520636f6d6d756e69747927732064657369726520666f7220617374726f6e6f6d6963616c206761696e732e20466561747572696e67206120706c617966756c206361742d696e2d7370616365207468656d652c20697427732064657369676e656420666f722066756e2c2073706563756c6174696f6e2c20616e642061206c696768746865617274656420617070726f61636820746f20646563656e7472616c697a65642066696e616e63652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wenmoon_ea77bc92a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WENWEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WENWEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

