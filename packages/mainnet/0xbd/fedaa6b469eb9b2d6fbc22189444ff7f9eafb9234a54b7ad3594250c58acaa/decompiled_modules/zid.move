module 0xbdfedaa6b469eb9b2d6fbc22189444ff7f9eafb9234a54b7ad3594250c58acaa::zid {
    struct ZID has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZID>(arg0, 9, b"ZID", b"YAZID", b"ZID is a meme token insipired by real figure with fullname HILMI YAZID", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/44d5fa3a-2043-4098-95b3-605bcfad52db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZID>>(v1);
    }

    // decompiled from Move bytecode v6
}

