module 0xaa2367f920cebaef55618d6b0d94e06991941264ba7e1ac249996d5e7573b04b::ccat {
    struct CCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCAT>(arg0, 9, b"Ccat", b"Cat gem on Sui", b"For all cat lovers on Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/db38bbcf10fcee8639392d6e5fb1e7e7blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

