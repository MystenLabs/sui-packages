module 0x3948d00090ef97c7f84227518f5d7d4905c0701f29348479726ca80853605e4c::usdsui {
    struct USDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDSUI>(arg0, 9, b"USDSUI", b"Sui Dollar", b"USDsui is Sui's native, USD-backed stablecoin, issued via Bridge's Open Issuance platform and built for regulatory compliance. It powers payments, DeFi, and on-chain commerce across the Sui ecosystem, while seamlessly interoperating with other Bridge-issued stablecoins to enable global liquidity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-space-bucket-fra1-1.fra1.cdn.digitaloceanspaces.com/usd_sui_9fe1dc4ef8.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDSUI>>(0x2::coin::mint<USDSUI>(&mut v2, 5000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<USDSUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

