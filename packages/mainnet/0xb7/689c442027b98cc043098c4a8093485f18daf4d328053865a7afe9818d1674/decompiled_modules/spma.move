module 0xb7689c442027b98cc043098c4a8093485f18daf4d328053865a7afe9818d1674::spma {
    struct SPMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPMA>(arg0, 0x9e20798d97c110f6b36b7b3d8543aa9246322ef2fd8d83ad79ef3325d473bc2f::constants::lp_decimals(), b"SPMA", b"3xSPMA375", b"3x S&P500 MA375 Trend-Following", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

