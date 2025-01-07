module 0x1c351bf9ff0ce86434666a6f8e82e5371682db1a63e611fb76b4e86578fe97e2::spepe {
    struct SPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEPE>(arg0, 6, b"SPEPE", b"SUI PEPE", b"Pepe on Sui blockchain brings the ultimate meme coin vibes, where speed and low fees are king. We're talking lightning-fast transactions, almost zero gas, and all the chaotic, fun Pepe energy you lovenow supercharged on a next-gen platform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_04_43_20_783e974094.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

