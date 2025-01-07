module 0xd1826abebbfb4aac5e4bb165d2c8e282fdb939f2d4e75ac14b95b53b95ca4bd7::fry {
    struct FRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRY>(arg0, 6, b"FRY", b"FRY on SUI", x"f09d9799f09d97bcf09d97bf20f09d9798f09d9883f09d97b2f09d97bff09d9886f09d97bcf09d97bbf09d97b22e20f09d9794f09d97b9f09d97b920f09d97a2f09d97bff09d97b4f09d97aef09d97bbf09d97b6f09d97b020f09d979af09d97bff09d97bcf09d9884f09d9881f09d97b53b20f09d97a1f09d97bc20f09d97a3f09d97aef09d97b6f09d97b120f09d97a3f09d97bff09d97bcf09d97baf09d97bcf09d9881f09d97b6f09d97bcf09d97bbf09d98800a0a4261736564206f6e2074686520706f70756c6172206d656d6573206f66204672792c202446525920697320636f6d696e6720746f2053756921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731343752644.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

