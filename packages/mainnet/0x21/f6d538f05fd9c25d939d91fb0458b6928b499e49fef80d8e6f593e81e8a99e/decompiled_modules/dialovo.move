module 0x21f6d538f05fd9c25d939d91fb0458b6928b499e49fef80d8e6f593e81e8a99e::dialovo {
    struct DIALOVO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIALOVO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIALOVO>(arg0, 6, b"Dialovo", b"Diavolo", b"About to claim my territory in Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_09_at_8_20_15a_PM_cdfa3aac62.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIALOVO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIALOVO>>(v1);
    }

    // decompiled from Move bytecode v6
}

