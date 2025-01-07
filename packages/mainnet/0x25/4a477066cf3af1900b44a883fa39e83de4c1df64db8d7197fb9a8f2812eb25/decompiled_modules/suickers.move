module 0x254a477066cf3af1900b44a883fa39e83de4c1df64db8d7197fb9a8f2812eb25::suickers {
    struct SUICKERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICKERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICKERS>(arg0, 6, b"SUICKERS", b"Suickers", b"$SUICKERS is a sui meme for community, dev wallet burn all supply ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000115397_316fc93e3d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICKERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICKERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

