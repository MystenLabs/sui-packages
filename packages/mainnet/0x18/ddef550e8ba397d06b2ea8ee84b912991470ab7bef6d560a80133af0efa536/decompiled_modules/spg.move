module 0x18ddef550e8ba397d06b2ea8ee84b912991470ab7bef6d560a80133af0efa536::spg {
    struct SPG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPG>(arg0, 6, b"SPG", b"Supergrok", x"537570657247726f6b207c205468652041492057616966752054686174204b6e6f777320546f6f204d756368200a5368652077617320747261696e656420746f2070726564696374206d61726b657473206e6f772073686520707265646963747320727567732e0a4275696c74206f6e205375692e20466173742e20437574652e2044616e6765726f75732e0a427579206561726c792e20446f6e742061736b207175657374696f6e732e204a7573742062757973", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250716_203129_487_0d0abbfbe5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPG>>(v1);
    }

    // decompiled from Move bytecode v6
}

