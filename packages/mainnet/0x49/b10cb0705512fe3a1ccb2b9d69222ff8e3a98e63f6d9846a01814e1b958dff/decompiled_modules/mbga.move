module 0x49b10cb0705512fe3a1ccb2b9d69222ff8e3a98e63f6d9846a01814e1b958dff::mbga {
    struct MBGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBGA>(arg0, 6, b"MBGA", b"MakeBullrunGreateAgain", x"244d4247412069732074686520756c74696d617465206d656d6520746f6b656e2074616b696e67206f766572205355492074686973204f63746f626572212047657420726561647920746f20756e6c6561736820796f757220696e6e65722062756c6c20616e642072696465207468652077696c64206d61726b65742077617665732061732077652063656c6562726174652074686520746872696c6c206f66207468652070756d70210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Yzs_Vq_D_Ws_Agh6_CD_9ba15e399f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MBGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

