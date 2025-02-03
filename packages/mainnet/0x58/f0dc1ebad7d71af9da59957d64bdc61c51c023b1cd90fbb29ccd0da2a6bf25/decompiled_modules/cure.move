module 0x58f0dc1ebad7d71af9da59957d64bdc61c51c023b1cd90fbb29ccd0da2a6bf25::cure {
    struct CURE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CURE>(arg0, 6, b"CURE", b"THE OFFICIAL CURE", x"544845204f4646494349414c20435552450a0a4d6565742047524f56455220746865206f6666696369616c204355524520746f206d656d652b7574696c6974792c2066726f6d207468652073747265657473206f6620736573616d6520746f20535549210a20446563656e7472616c697a65642066696e616e63652069732074686520667574757265206f66207068696c616e7468726f7079200a41204d454d452057495448204120505552504f53452c204a4f494e20544845204d4f56454d454e54210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738603445914.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CURE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CURE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

