module 0x8e9632423ea4b218b6a8dd86a1502c184caa36b5b11eace36e090c66a871da19::goddess {
    struct GODDESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODDESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODDESS>(arg0, 6, b"Goddess", b"Goddess Sui", b"Pay tribute to the goddess.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigliwgsm5bcyfgx3645phi3zmxs4ofkbchmbqwm2mv6hkhjjmykv4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODDESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GODDESS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

