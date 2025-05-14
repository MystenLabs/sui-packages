module 0xeb79e24f1a1541a4621e3586880bcd4ecab75b09332de88b4e5d16b44e5d85ef::oct {
    struct OCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCT>(arg0, 6, b"OCT", b"Octopus Gap", b"Oct is an octopus populating the Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000069743_554eb64a15.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

