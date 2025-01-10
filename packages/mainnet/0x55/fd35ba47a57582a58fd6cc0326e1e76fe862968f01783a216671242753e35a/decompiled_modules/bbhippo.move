module 0x55fd35ba47a57582a58fd6cc0326e1e76fe862968f01783a216671242753e35a::bbhippo {
    struct BBHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBHIPPO>(arg0, 6, b"BBHIPPO", b"Baby Hippo", b"Baby Hippo is a memecoin based on the Sui blockchain, inspired by the famous pygmy hippopotamus named Moo Deng, born on July 10, 2024 at Khao Kheow Zoo in Thailand.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736550020242.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBHIPPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBHIPPO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

