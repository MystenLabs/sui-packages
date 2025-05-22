module 0x6a63aa1cc5d385f49f0b8b42774f6327ed82f5caec9a9060748571746853604f::kingdra {
    struct KINGDRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGDRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGDRA>(arg0, 6, b"Kingdra", b"Kingdra Pokemon", b"THIS TOKEN IS NOT JUST A DIGITAL ASSET, IT IS A SYMBOL OF $KINGDRA INCREDIBLE JOURNEY AND THE INSIGHTS HE GAINED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihdgai3xdsv6os6vqwrjbl4sfykfbjyba3zlldx73jsnieyskphdm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGDRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KINGDRA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

