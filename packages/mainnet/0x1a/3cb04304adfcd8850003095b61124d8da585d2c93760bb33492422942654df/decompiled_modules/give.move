module 0x1a3cb04304adfcd8850003095b61124d8da585d2c93760bb33492422942654df::give {
    struct GIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIVE>(arg0, 9, b"Give", b"GiveRep", b"The reputation must flow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a565b606a0327b721fbffa4fba6fc4d2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

