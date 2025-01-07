module 0x2c852ea25456907eec3a8dd2067f904e82a5ad2f043ea1199537cf139cb34007::smi {
    struct SMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMI>(arg0, 6, b"SMI", b"Smiski on SUI", b"The only token that memes IRL has arrived.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dynw_W8j1_400x400_d9700afabf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

