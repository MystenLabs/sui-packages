module 0x33ea6699758ce8fdf75a7dc97067f8258e1b4dbbf4fe605290bc208dc20acaa1::sadkins {
    struct SADKINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADKINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADKINS>(arg0, 6, b"SADKINS", b"Popkins Reject Club", x"4469646e27742067657420796f757220506f706b696e733f205370656e7420243136303020646f6c6c61727320616e64207374696c6c206469646e277420676574206f6e653f20546f6f2062726f6b6520746f20627579207061636b733f0a0a49742773206f6b61792e2e2e206a75737420636f6d65206a6f696e2074686520636c75622c2065766572796f6e6527732077656c636f6d6520686572650a0a4174206c6561737420796f75206d69676874206d616b6520736f6d65206d6f6e6579207468697320776179", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749032418864.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SADKINS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADKINS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

