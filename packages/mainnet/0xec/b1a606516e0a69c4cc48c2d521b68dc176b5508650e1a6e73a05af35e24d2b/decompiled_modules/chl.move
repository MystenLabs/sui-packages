module 0xecb1a606516e0a69c4cc48c2d521b68dc176b5508650e1a6e73a05af35e24d2b::chl {
    struct CHL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHL>(arg0, 9, b"CHL", b"lilith", b"This token is from a collection of Lilith and Lucifer's children, consisting of 101 designs with their enchantments and magic spells. If this is sold out, the rest of the tasks will also be minted.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8727797-68f7-48f7-82ad-dbcc068aec74.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHL>>(v1);
    }

    // decompiled from Move bytecode v6
}

