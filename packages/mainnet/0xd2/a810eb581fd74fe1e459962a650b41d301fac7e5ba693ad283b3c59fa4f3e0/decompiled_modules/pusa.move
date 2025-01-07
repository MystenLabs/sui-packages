module 0xd2a810eb581fd74fe1e459962a650b41d301fac7e5ba693ad283b3c59fa4f3e0::pusa {
    struct PUSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSA>(arg0, 9, b"PUSA", b"PepeUSA", b"Pepe USA stands guard", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4ca18b5-4b3e-4b04-bc13-48372b857754-IMG_1345.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

