module 0xe16adf21363fc76fdcec1524b55346bdfee8553ade36d566eccf105337b31062::nap {
    struct NAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAP>(arg0, 6, b"NAP", b"KOALA RESERVE", x"536f6d657468696e67206269672069732067726f77696e6720696e2073696c656e63650a412072657365727665207468617420696e63726561736573206576657279206461792e0a4275696c7420666f722074686f73652077686f20736565206974206265666f726520746865206f74686572732e0a0a49747320636f6d696e672e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054024_af27dfc30f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

