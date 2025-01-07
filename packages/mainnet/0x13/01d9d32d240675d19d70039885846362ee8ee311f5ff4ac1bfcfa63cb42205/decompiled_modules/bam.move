module 0x1301d9d32d240675d19d70039885846362ee8ee311f5ff4ac1bfcfa63cb42205::bam {
    struct BAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAM>(arg0, 6, b"BAM", b"Saca", b"Stupid looking fish on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036550_39e985062f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

