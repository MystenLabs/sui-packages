module 0x5f7fd113204bab16fb76394894b6a32ec9a5399b6d1d110b216f0fcc2ea412da::jelli {
    struct JELLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELLI>(arg0, 6, b"Jelli", b"Iggy's dog Jelli", b"Iggy Azalea's offcial Dog on Sui. you know the ticker, its $Jelli", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_1_af13456cb6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JELLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

