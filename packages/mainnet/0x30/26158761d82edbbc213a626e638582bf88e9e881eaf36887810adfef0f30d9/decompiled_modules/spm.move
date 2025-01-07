module 0x3026158761d82edbbc213a626e638582bf88e9e881eaf36887810adfef0f30d9::spm {
    struct SPM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPM>(arg0, 6, b"SPM", b"MMM Global", b"It's more expensive today than yesterday!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_ad5001109b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPM>>(v1);
    }

    // decompiled from Move bytecode v6
}

