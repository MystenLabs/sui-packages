module 0x1f3e3e30dbae7e70ca7036fc6fa4885de476a91effb8fed03a3a1d7c433566a3::spma {
    struct SPMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPMA>(arg0, 0x9e20798d97c110f6b36b7b3d8543aa9246322ef2fd8d83ad79ef3325d473bc2f::constants::lp_decimals(), b"SPMA", b"3xSPMA375", b"Systematic S&P500 Exposure with Crash Protection", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

