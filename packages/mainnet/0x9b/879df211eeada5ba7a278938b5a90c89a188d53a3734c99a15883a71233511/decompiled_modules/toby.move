module 0x9b879df211eeada5ba7a278938b5a90c89a188d53a3734c99a15883a71233511::toby {
    struct TOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOBY>(arg0, 6, b"TOBY", b"Tobydog On Sui", x"544f4259202d206973206120736d6172742c0a6d756c74692d74616c656e74656420646f672077686f0a63616e20646f207768617465766572206869730a6d61737465722077616e7473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001690_1776fc38d2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

