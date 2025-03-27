module 0xd925728cf4765600d1b002ac0c74aed77a887e6eea570ebcee49ce18fd4a1747::twixi {
    struct TWIXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWIXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWIXI>(arg0, 9, b"Twixi", b"Twixie", x"54776978696520e2809320537765657420616e642066756c6c206f6620706c617966756c205055505059", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/54558b04e9e880f83f2c37e7912d9fa4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWIXI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWIXI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

