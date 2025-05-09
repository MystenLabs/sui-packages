module 0xe7bd47c8dd041bcb8604eae80e1b541081c047f8a176aeeecefc0199212c5a44::doug {
    struct DOUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOUG>(arg0, 6, b"Doug", b"Douggy", x"526f61646d61703a2070756d7020446f756720746f203130306d696c203d206e65772065796573206f6e20537569203d20537569206d656d6520736561736f6e207374617274730a0a446f7567206c696b652077617465722c20446f756720737570706f727420737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifb2blumi2hdxl2ilzcitmgcatnaiabn5noenswes7gav6tgz2coy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOUG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

