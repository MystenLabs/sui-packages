module 0x239024aa49a16b7cc69325bff90f3ca628e7b94f61a3a07ca6252459d20e1200::snekky {
    struct SNEKKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEKKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEKKY>(arg0, 6, b"SNEKKY", b"Snekky by Matt Furrie", b"Meet Snekky, the vibrant and adventurous snake from Matt Furie's Night Riders. 2025, the Year of the Snake, is shaping up to be a bullish year.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250117_191804_389_3f5653e588.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEKKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNEKKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

