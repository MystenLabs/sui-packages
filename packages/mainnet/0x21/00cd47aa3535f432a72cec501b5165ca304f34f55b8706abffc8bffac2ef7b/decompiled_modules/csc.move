module 0x2100cd47aa3535f432a72cec501b5165ca304f34f55b8706abffc8bffac2ef7b::csc {
    struct CSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSC>(arg0, 9, b"CSC", b"Chop Sui Coin", x"4368616f73206d6565747320696e6e6f766174696f6e206f6e207468652053554920626c6f636b636861696ee28094666173742c207363616c61626c652c20616e64206275727374696e67207769746820656e657267792e205065726665637420666f722074686f73652077686f206372617665206578636974656d656e7420616e6420656666696369656e63792e2057616b6520757020746f20746865206d656d6520636f696e2074686174207368616b6573207570207468652073797374656d21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b0957c53c9f20b67e524eed5ebbedddeblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CSC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

