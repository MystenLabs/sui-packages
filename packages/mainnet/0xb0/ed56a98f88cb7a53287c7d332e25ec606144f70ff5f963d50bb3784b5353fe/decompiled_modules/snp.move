module 0xb0ed56a98f88cb7a53287c7d332e25ec606144f70ff5f963d50bb3784b5353fe::snp {
    struct SNP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNP>(arg0, 9, b"SNP", b"Snoop", b"Snoop's $poopin around", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ad3135fb-ccea-42c8-bf9c-958a36b3f64e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNP>>(v1);
    }

    // decompiled from Move bytecode v6
}

