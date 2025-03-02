module 0xebd49c8033be5ac18a3e1ac0c1b022bcd4fd825e79060fb837bcc69efe5ab0a4::schick {
    struct SCHICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHICK>(arg0, 9, b"SCHICK", b"SUI Chicken", b"The first and only chicken of the SUI ecosystem!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2de59b11867e1f9a81db78507a580c48blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCHICK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHICK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

