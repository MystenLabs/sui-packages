module 0x19c776e6e39d4f1b3f0a1118bc76b93daa64bc80d97dfe07ffd8c995a3eb3e18::stew {
    struct STEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEW>(arg0, 6, b"STEW", b"SUI STEWIE", b"For the bold and the witty, inspired by a legendary character who never follows the rules. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/STEWIESREWIE_Copy_43a70ae16b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

