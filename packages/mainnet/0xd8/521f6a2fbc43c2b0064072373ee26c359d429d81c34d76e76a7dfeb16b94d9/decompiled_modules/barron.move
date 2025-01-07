module 0xd8521f6a2fbc43c2b0064072373ee26c359d429d81c34d76e76a7dfeb16b94d9::barron {
    struct BARRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARRON>(arg0, 6, b"Barron", b"SUI TRUMP SON", x"225468652046757475726520697320595547452120536f6e206f66205472756d7020436f696e4275696c7420666f7220426f6c64204d6f76657320616e6420426967204761696e732e20486f6c642c2057696e2c20616e64204d616b65204d656d6520436f696e7320477265617420416761696e21220a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014691_05ad9c0a04.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARRON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARRON>>(v1);
    }

    // decompiled from Move bytecode v6
}

