module 0x9bb19a92348f26a0033d904cbc984494396d0edadd1478f8b2ff1dd854d23758::bstn {
    struct BSTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSTN>(arg0, 9, b"Bstn", b"boston", b"i,m brazil in boston", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9dbb2b951b50594b09fe0171c02f215ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSTN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSTN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

