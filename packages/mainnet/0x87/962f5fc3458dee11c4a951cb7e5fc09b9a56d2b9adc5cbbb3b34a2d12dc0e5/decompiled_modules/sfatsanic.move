module 0x87962f5fc3458dee11c4a951cb7e5fc09b9a56d2b9adc5cbbb3b34a2d12dc0e5::sfatsanic {
    struct SFATSANIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFATSANIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFATSANIC>(arg0, 6, b"SFATSANIC", b"Sui Fat Sanic", b"Expect wild price jumps and meme-worthy market sprints as Sui Fat Sanic barrels forward with all the grace of a wrecking ball. Gotta go fast...ish!  #TooFatTooFast #SanicSpeed #SuiMemes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gif_trans_285b6bd55e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFATSANIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFATSANIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

