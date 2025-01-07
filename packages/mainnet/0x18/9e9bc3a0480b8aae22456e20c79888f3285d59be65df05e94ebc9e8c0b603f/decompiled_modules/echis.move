module 0x189e9bc3a0480b8aae22456e20c79888f3285d59be65df05e94ebc9e8c0b603f::echis {
    struct ECHIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECHIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECHIS>(arg0, 6, b"ECHIS", b"erect chicken horse in space", b"The real meme token sui,, a chicken with a horse c^ck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241222_170220_289_15a1ab3680.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECHIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ECHIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

