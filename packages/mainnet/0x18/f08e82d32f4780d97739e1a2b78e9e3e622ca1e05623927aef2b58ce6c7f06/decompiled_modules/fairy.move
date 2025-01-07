module 0x18f08e82d32f4780d97739e1a2b78e9e3e622ca1e05623927aef2b58ce6c7f06::fairy {
    struct FAIRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAIRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAIRY>(arg0, 6, b"FAIRY", b"FairyFish", x"4120676c6974746572792064697661206f6620746865207365612c207377696d6d696e67206c696b65206974e2809973206175646974696f6e696e6720666f72205377616e204c616b652e20497420737072696e6b6c6573206d616769632064757374206f6e20736561206372656174757265732c207475726e696e67207468656d20737061726b6c7920616e6420636f6e66757365642e205761726e696e673a20676c6974746572206d617920666f6c6c6f772e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730965060557.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAIRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAIRY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

