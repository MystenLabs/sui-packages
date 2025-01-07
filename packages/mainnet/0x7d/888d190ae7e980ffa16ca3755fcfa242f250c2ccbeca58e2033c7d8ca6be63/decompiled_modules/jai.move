module 0x7d888d190ae7e980ffa16ca3755fcfa242f250c2ccbeca58e2033c7d8ca6be63::jai {
    struct JAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAI>(arg0, 6, b"JAI", b"WORLDWAR JELLY AI", x"4a414920544f4b454e20697320636f6d696e6720746f20537569204e6574776f726b207769746820616e204558504c4f5349564520666f7263652120f09f9a80205765e2809972652061626f757420746f204348414e4745205448452047414d452077697468207468652066697273742d6576657220414920746f6b656e20696e207468652065636f73797374656d212054686973206973206a7573742074686520626567696e6e696e673b205448452046555455524520535441525453204e4f57210a0a0a434f4445203a200a203638203336203237203239203637202d203738203935", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731006550265.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

