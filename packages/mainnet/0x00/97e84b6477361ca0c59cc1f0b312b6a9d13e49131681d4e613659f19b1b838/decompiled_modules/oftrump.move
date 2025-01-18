module 0x97e84b6477361ca0c59cc1f0b312b6a9d13e49131681d4e613659f19b1b838::oftrump {
    struct OFTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: OFTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OFTRUMP>(arg0, 9, b"OFTRUMP", b"OFFICIAL TRUMP SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/VQrPjACwnQRmxdKBTqNwPiyo65x7LAT773t8Kd7YBzw")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OFTRUMP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OFTRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OFTRUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

