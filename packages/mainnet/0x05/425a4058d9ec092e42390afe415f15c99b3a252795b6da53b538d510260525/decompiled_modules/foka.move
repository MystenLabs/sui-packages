module 0x5425a4058d9ec092e42390afe415f15c99b3a252795b6da53b538d510260525::foka {
    struct FOKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOKA>(arg0, 6, b"FOKA", b"It's FOKA", x"416e20616c69656e206e616d656420466f6b61206861732063726173682d6c616e646564206f6e2045617274682c20636f6d6d756e69636174696e6720736f6c656c79207468726f7567682074686520776f726420464f4b4120696e2076617269656420746f6e657320616e6420706974636865732e205468697320416c69656e20747279696e6720746f20756e6465727374616e64207768617420646120464f4b4120697320676f696e67206f6e20776974682045617274682e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/foka_logo_7f28c3a587.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

