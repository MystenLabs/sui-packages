module 0x4c49ab6851a38cedc53e23a17a9a48ee51ba9a419b9d77b11eae3e6b26260144::sprearl {
    struct SPREARL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPREARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPREARL>(arg0, 6, b"SPREARL", b"SUI PEARL", b"SUI PEARL token is a digital asset on the SUI blockchain. It's used for transactions, staking, and governance within the SUI ecosystem. Think of it like a shiny pearl in the sea of cryptocurrencies!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240921_233058_591_d6a4ceef69.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPREARL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPREARL>>(v1);
    }

    // decompiled from Move bytecode v6
}

