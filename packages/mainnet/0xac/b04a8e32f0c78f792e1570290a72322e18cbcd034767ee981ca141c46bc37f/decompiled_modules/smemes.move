module 0xacb04a8e32f0c78f792e1570290a72322e18cbcd034767ee981ca141c46bc37f::smemes {
    struct SMEMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMEMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMEMES>(arg0, 6, b"SMEMES", b"SQUIDMEME", b"Squid Memes Relaunch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7181_f6d9104ac2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMEMES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMEMES>>(v1);
    }

    // decompiled from Move bytecode v6
}

