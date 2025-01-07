module 0x1689875b075fad6206124bc5cabdeed6061e5605845a16b48916756eb6c42c79::hst {
    struct HST has drop {
        dummy_field: bool,
    }

    fun init(arg0: HST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HST>(arg0, 6, b"Hst", b"Hamster for fun", b"hamsteria", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_220451_dd93ffedba.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HST>>(v1);
    }

    // decompiled from Move bytecode v6
}

