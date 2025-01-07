module 0xace3b261beb089d0537730aaf7ee258147380aafa73a2772dc686126dce05c3c::asd {
    struct ASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASD>(arg0, 6, b"ASD", b"ASD", b"The Official Bonk Inu token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.okx.com/cdn/wallet/logo/Bonk-20230106.png?x-oss-process=image/format,webp/ignore-error,1"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASD>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASD>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASD>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

