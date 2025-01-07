module 0xa216f05a61ce1305d6c11be516830ffc37a8f7356f88a1fcd415b572d419cb5f::duduck {
    struct DUDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUDUCK>(arg0, 9, b"DUDUCK", b"DuckyDuck", b"Token for some one have a duck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/beac8269-3a61-40ec-bde4-8f5213304cbc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

