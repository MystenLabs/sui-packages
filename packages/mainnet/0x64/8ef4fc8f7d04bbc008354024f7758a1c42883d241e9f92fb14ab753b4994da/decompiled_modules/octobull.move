module 0x648ef4fc8f7d04bbc008354024f7758a1c42883d241e9f92fb14ab753b4994da::octobull {
    struct OCTOBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOBULL>(arg0, 6, b"OCTOBULL", b"$OCTOBULL", b"$OCTOBULL is a meme token built on the SUI blockchain, and SUI has already soared to the moon. Celebrate and strengthen its community together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gssdgsdgge_4c7b3f885b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTOBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

