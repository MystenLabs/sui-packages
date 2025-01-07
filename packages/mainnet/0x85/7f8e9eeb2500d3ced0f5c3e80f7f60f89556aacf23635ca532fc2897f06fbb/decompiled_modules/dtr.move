module 0x857f8e9eeb2500d3ced0f5c3e80f7f60f89556aacf23635ca532fc2897f06fbb::dtr {
    struct DTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTR>(arg0, 9, b"DTR", b"DTRUMP", b"represents a passionate love of crypto and admiration for the 47th president of the United States", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b5c49427-67f2-4d43-b62c-bd6cf96f2eb8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

