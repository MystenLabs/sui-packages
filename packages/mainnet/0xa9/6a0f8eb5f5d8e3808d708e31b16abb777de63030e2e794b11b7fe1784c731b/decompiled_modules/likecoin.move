module 0xa96a0f8eb5f5d8e3808d708e31b16abb777de63030e2e794b11b7fe1784c731b::likecoin {
    struct LIKECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIKECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIKECOIN>(arg0, 9, b"LIKECOIN", b"THE LIKECOIN", b"The definitive Likecoin for all networks. And we are better than Litecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/db80737ff1593c900647063205716967blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIKECOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIKECOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

