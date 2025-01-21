module 0xa938b5b16866cd8a9bd3beb8579debe432ecc623afd8d0de30f21ff55240882c::dope {
    struct DOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPE>(arg0, 9, b"DOPE", b"DOGE & PEPE Bred", b"DOGE & PEPE Had A Son!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4511081701df2dea08a3ba77a07a67f1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

