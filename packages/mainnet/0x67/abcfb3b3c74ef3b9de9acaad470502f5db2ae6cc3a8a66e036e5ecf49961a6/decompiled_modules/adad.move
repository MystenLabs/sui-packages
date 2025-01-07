module 0x67abcfb3b3c74ef3b9de9acaad470502f5db2ae6cc3a8a66e036e5ecf49961a6::adad {
    struct ADAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADAD>(arg0, 6, b"ADAD", b"Adansonia Digitata", b"A baobab tree never grows alone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/man_8559535_1280_40561057ff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

