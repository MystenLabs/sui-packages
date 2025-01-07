module 0x2c5edd6711f88b9f9608774a9852e66f8e9becf3b16960e503c8684434fdd9f1::snp {
    struct SNP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNP>(arg0, 9, b"SNP", b"Snoop", b"Snoop's $poopin around", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cfd8cdff-d9e3-4138-9a79-beff922b99b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNP>>(v1);
    }

    // decompiled from Move bytecode v6
}

