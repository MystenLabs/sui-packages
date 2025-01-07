module 0xae70120916911a93f2295b54f65de9c94349606df617d6e7a9884822bc67ecfd::turkey {
    struct TURKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURKEY>(arg0, 4, b"TURKEY", b"TURKEY", b"a private TURKEY for sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a3-q.mafengwo.net/s9/M00/8C/0F/wKgBs1eyywmAVMsjAAmQf3sPcBY62.jpeg?imageView2/2/w/800/q/90/format/jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURKEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURKEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TURKEY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TURKEY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

