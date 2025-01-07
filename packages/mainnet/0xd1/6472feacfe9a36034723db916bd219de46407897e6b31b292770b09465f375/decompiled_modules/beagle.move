module 0xd16472feacfe9a36034723db916bd219de46407897e6b31b292770b09465f375::beagle {
    struct BEAGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAGLE>(arg0, 6, b"BEAGLE", b"Big Beagle", b"Behold the Bold Bald-Beagle. A savior made of Bark and Bird. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/beagle_b894c6a593.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAGLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEAGLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

