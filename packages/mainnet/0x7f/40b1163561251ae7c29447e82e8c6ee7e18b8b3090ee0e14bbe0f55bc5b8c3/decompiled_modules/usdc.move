module 0x7f40b1163561251ae7c29447e82e8c6ee7e18b8b3090ee0e14bbe0f55bc5b8c3::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 6, b"USDC", b"USDC", b"USDC is a US dollar-backed stablecoin issued by Circle. USDC is designed to provide a faster, safer, and more efficient way to send, spend, and exchange money around the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/usdc_03b37ed889.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC>>(v1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<USDC>(&mut v2, 1000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

