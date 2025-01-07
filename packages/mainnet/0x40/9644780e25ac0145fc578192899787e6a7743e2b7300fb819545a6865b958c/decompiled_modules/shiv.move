module 0x409644780e25ac0145fc578192899787e6a7743e2b7300fb819545a6865b958c::shiv {
    struct SHIV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIV>(arg0, 6, b"SHIV", b"ShivaInuOnSui", x"534849564120494e550a5574696c697a696e6720636f6d6d756e69747920706f77657220696e207468652067726f77696e6720544f4e20446546692065636f73797374656d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241010_162422_ab752fd814.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIV>>(v1);
    }

    // decompiled from Move bytecode v6
}

