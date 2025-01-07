module 0x2e2f4349301591a0e572ad94a6a95be64937d7cf5a0ed22e017773d25e4f6207::suilami {
    struct SUILAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAMI>(arg0, 9, b"SUILAMI", b"Suilami", b"first Suilami ever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"1")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUILAMI>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAMI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

