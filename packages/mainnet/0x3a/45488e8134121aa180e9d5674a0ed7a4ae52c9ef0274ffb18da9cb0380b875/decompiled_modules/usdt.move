module 0x3a45488e8134121aa180e9d5674a0ed7a4ae52c9ef0274ffb18da9cb0380b875::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT>(arg0, 6, b"USDT", b" USDT v3 (Swap at: usdv3.com)", b"Swap USDT to USDT v3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://seeklogo.com/images/T/tether-usdt-logo-FA55C7F397-seeklogo.com.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDT>(&mut v2, 10000000000 * 0x1::u64::pow(10, 6), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

