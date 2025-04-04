module 0x7e78642081abca035cd3eca91f4e10252b767e8392c0ca7dab637084eca5d96c::dawgg {
    struct DAWGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAWGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAWGG>(arg0, 6, b"DAWGG", b"SUNDAWGG", x"53756e20446177676720282453554e4441574747292069732074686520686f7474657374206d656d65636f696e20756e646572207468652073756ee28094626c617a696e6720776974682076696265732c20706f7765726564206279206d656d65732c20616e64206c65642062792061206c6f79616c207061636b2e204e6f207574696c6974792c206a7573742070757265206261726b2d746f2d7468652d6d6f6f6e20656e657267792e20f09f8c9ef09f90b6204a6f696e207468652064617767677061636b20616e64207269646520746865207261797320746f20676c6f727921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1743723105588.44")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAWGG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAWGG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

