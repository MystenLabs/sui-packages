module 0xdac67e83607905ea6c211aa0fb7538fbd6afdb3f9bd81219f35ec01f57868beb::active {
    struct ACTIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACTIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACTIVE>(arg0, 6, b"Active", b"NGN", b"no need for explanation well go to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735383673467.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACTIVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACTIVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

