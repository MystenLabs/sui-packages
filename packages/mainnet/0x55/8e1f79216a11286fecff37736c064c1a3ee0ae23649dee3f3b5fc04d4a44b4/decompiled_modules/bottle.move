module 0x558e1f79216a11286fecff37736c064c1a3ee0ae23649dee3f3b5fc04d4a44b4::bottle {
    struct BOTTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOTTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOTTLE>(arg0, 6, b"Bottle", b"Sui Bottle Coffee", b"Is there anything better than the sweet and savory smells of fall? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1mn_E_Pbjo_400x400_1_efbcbcc193.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOTTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOTTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

