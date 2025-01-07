module 0xd3ed653ac39eefbcc7bcf6708f211582b082de710bdc5a055c3bfa99bd06114c::brd {
    struct BRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRD>(arg0, 9, b"BRD", b"BIRDS COIN", b"BIRDS COIN is created on Sui blockchain and have Ecosystem of Core Dao, With the help of these two powerful Blockchains BIRDS COIN will make his history.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9168250e-ce1a-4b8a-a056-b2a72f75a42d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

