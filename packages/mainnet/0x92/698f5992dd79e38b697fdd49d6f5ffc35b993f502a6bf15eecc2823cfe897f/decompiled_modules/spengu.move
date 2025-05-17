module 0x92698f5992dd79e38b697fdd49d6f5ffc35b993f502a6bf15eecc2823cfe897f::spengu {
    struct SPENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPENGU>(arg0, 6, b"SPENGU", b"SUI PENGU", b"sui pengu sui pengu sui pengu sui pengu sui pengu sui pengu sui pengu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihe32n557yudhyc6hxptononwgjdc5nkqjypocgtfrnbinxkojcry")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPENGU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

