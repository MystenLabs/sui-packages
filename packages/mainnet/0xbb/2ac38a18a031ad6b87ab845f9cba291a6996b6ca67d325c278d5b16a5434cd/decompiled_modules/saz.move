module 0xbb2ac38a18a031ad6b87ab845f9cba291a6996b6ca67d325c278d5b16a5434cd::saz {
    struct SAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAZ>(arg0, 6, b"SAZ", b"asda", b"asdzxc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730970892907.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

