module 0xc8963ab008f0500385abad72a7e7daaeff4c7f1d85c8630f6944265a2e2829b7::ddk {
    struct DDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDK>(arg0, 9, b"DDK", b"DavianDK", b"Davian is the best Dragon Knight", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1fff4f77-bdd6-403c-99af-cbceb3de0c09.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDK>>(v1);
    }

    // decompiled from Move bytecode v6
}

