module 0x3bf848038822cc4aa78cba7746912b777f24a6058bc6e77e09841081c7e66558::capy {
    struct CAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPY>(arg0, 6, b"CAPY", b"SUICAPY", x"446f6e277420776f7272792c2062652043415059210a0a496e207468652064656570206d756464792077617465727320736f6d65776865726520696e207468652077696c642c204341505920697320656e6a6f79696e6720612076616361792077697468206869732066656c6c6f77206361707962617261732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_Ur_C8_WTG_400x400_3aea41ace0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

