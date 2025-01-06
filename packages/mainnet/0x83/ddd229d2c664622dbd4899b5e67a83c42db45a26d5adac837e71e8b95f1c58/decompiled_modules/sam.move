module 0x83ddd229d2c664622dbd4899b5e67a83c42db45a26d5adac837e71e8b95f1c58::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAM>(arg0, 9, b"SAM", b"SUI APE MUSEUM", b"SUI APE MUSEUM  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3e06c91abde607a1b2bb91b50dbe1c9cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

