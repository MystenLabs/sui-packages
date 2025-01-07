module 0x6721727ed5a65bcac7e4651267ca1535fc3299fde6ecfeb3583d0b9133f25da4::wonky {
    struct WONKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WONKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WONKY>(arg0, 6, b"WONKY", b"WonkyCat", b"The newest meme coin on $SUI. Be the naughty Cat in Make #Sui Great Again with $WONKY. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731020517180.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WONKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WONKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

