module 0x225e3d741b0200f663bd4e79d67449c1f1fa3852c5871c652622b3f9a1f82394::jinping {
    struct JINPING has drop {
        dummy_field: bool,
    }

    fun init(arg0: JINPING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JINPING>(arg0, 6, b"JINPING", b"SUI Jinping", b"The President of People's Republic of Suina $JINPING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_e_a_1_48ebf20afd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JINPING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JINPING>>(v1);
    }

    // decompiled from Move bytecode v6
}

