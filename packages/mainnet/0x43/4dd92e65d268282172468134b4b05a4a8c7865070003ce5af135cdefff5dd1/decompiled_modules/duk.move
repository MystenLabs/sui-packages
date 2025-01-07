module 0x434dd92e65d268282172468134b4b05a4a8c7865070003ce5af135cdefff5dd1::duk {
    struct DUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUK>(arg0, 6, b"DUK", b"$DUK", x"476c6964696e6720736d6f6f74686c79206163726f7373207468652053756920636861696e206c616b652c202444554b206566666f72746c6573736c7920646f6467657320666f78657320616e642062656172732c206c656176696e6720612077616b65206f66206d656d657320626568696e642e0a0a5769746820657665727920666c61702c20776520736f6172206869676865722c20616e6420656163682027717561636b27206563686f6573206c6f75646572207468616e20746865206c61737421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731081636941.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

