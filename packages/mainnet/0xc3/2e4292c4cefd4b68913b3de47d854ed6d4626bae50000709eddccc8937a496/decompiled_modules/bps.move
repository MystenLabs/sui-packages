module 0xc32e4292c4cefd4b68913b3de47d854ed6d4626bae50000709eddccc8937a496::bps {
    struct BPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPS>(arg0, 6, b"BPS", b"banana peel sculpture", x"746865206f6e6c792062616e616e610a7065656c207363756c7074757265206f6e0a746865204d6f76652050756d70", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_Tela_2024_10_14_a_I_s_18_35_47_8b292dee1c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

