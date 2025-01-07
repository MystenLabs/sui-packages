module 0x654ddce84e1f05839903ce1882ef243282addd8ec5ba1addde16dd5a22511885::wonky {
    struct WONKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WONKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WONKY>(arg0, 6, b"WONKY", b"WonkyCat", b"The newest meme coin on $SUI. Be the naughty Cat in Make #Sui Great Again with $WONKY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730960444818.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WONKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WONKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

