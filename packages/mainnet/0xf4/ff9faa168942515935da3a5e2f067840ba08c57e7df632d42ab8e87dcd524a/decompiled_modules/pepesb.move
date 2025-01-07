module 0xf4ff9faa168942515935da3a5e2f067840ba08c57e7df632d42ab8e87dcd524a::pepesb {
    struct PEPESB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPESB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPESB>(arg0, 6, b"PEPESB", b"Pepe Sui Beats", x"506570652053756920426561747320282450455045534229206973206d6f7265207468616e206a7573742061206d656d6520746f6b656e3b206974e280997320612067726f77696e672065636f73797374656d207468617420626c656e6473207468652066756e206f66206d656d65732077697468207265616c207574696c69747920616e64206c6f6e672d7465726d2076616c756520666f722069747320636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954447319.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPESB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPESB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

