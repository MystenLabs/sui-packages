module 0xa76dd04835932fc8d82ee41f8042eca31f62bf41e12cb64cbfda891744b9679b::puggy {
    struct PUGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGGY>(arg0, 6, b"PUGGY", b"Puggy SUI", b"PUGGY the memecoin for everyone! Join a vibrant community driven by hard work and humor as we embark on a fun-filled ride to the moon and beyond. Buckle up, embrace the laughs, and lets make this journey unforgettable together!  #PuggyFamily", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250107_011340_655_757585c1cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

