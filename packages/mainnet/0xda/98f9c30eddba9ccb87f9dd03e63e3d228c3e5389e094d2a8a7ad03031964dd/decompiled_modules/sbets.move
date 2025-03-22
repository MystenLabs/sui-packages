module 0xda98f9c30eddba9ccb87f9dd03e63e3d228c3e5389e094d2a8a7ad03031964dd::sbets {
    struct SBETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBETS>(arg0, 9, b"sbets", b"Suibets", b"Betting protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/81778c70-0702-11f0-b264-5f08cd100cd6")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBETS>>(v1);
        0x2::coin::mint_and_transfer<SBETS>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBETS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

