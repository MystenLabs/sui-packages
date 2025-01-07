module 0x8a54644ba5180f42ced569a28d9522cd1ae99c9b852e20315162c6614e22d11b::bonk420 {
    struct BONK420 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONK420, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONK420>(arg0, 6, b"BONK420", b"SUI BONK 420", x"41726520796f7520726561647920666f7220746865206e657874204d756c7469204d696c6c7920616c7068612067656d206f6e205375693f0a0a426f6e6b3432303a20546865204d656d6520436f696e20546861742057696c6c204d616b6520596f7520486967682e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f39241c6f4b83bde37390c4e953b03ec_110d5190ee.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONK420>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONK420>>(v1);
    }

    // decompiled from Move bytecode v6
}

