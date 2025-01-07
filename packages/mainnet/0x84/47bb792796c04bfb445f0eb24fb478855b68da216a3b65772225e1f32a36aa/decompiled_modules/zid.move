module 0x8447bb792796c04bfb445f0eb24fb478855b68da216a3b65772225e1f32a36aa::zid {
    struct ZID has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZID>(arg0, 9, b"ZID", b"YAZID", b"ZID is a meme token insipired by real figure with fullname HILMI YAZID", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aef62db4-285b-4216-bc2a-eb76495d6f40.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZID>>(v1);
    }

    // decompiled from Move bytecode v6
}

