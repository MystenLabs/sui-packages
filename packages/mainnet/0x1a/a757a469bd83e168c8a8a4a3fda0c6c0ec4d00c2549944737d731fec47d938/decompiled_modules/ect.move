module 0x1aa757a469bd83e168c8a8a4a3fda0c6c0ec4d00c2549944737d731fec47d938::ect {
    struct ECT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECT>(arg0, 9, b"ECT", b"Elon Cat", b"Elon Cat was designed to celebrate the 2nd birthday of his cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/29652a39-2e86-4d8f-8404-aa3fe7d9cac5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ECT>>(v1);
    }

    // decompiled from Move bytecode v6
}

