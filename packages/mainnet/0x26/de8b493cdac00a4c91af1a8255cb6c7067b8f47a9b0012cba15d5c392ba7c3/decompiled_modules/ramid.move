module 0x26de8b493cdac00a4c91af1a8255cb6c7067b8f47a9b0012cba15d5c392ba7c3::ramid {
    struct RAMID has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAMID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAMID>(arg0, 6, b"RAMID", b"Sui Yramid", b"Join the $RAMID movement, Blue means resistance but still relaxed, that's the spirit shown by $RAMID", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250507_001710_0eb04e539e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAMID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAMID>>(v1);
    }

    // decompiled from Move bytecode v6
}

