module 0x36232b72d0e39fcf417dbd8b5a4b2f61c5d0893e4f2f5ab6593828e221687251::memex {
    struct MEMEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEX>(arg0, 6, b"MEMEX", b"MemeX", b"MemeX is a leading meme coin within the Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1742076485184.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

