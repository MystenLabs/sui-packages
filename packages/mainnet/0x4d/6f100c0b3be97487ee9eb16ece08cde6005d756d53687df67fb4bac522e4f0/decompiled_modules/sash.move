module 0x4d6f100c0b3be97487ee9eb16ece08cde6005d756d53687df67fb4bac522e4f0::sash {
    struct SASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASH>(arg0, 6, b"SASH", b"Sashimi", b"Only the very best food on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/magicstudio_art_2_2_aa77838783.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

