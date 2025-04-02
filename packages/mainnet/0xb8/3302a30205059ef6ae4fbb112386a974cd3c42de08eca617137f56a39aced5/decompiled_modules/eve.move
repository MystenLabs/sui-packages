module 0xb83302a30205059ef6ae4fbb112386a974cd3c42de08eca617137f56a39aced5::eve {
    struct EVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVE>(arg0, 9, b"Eve", b"evie", b"fun area to adopt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0116ad361135778d2a25ecee5a4df903blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

