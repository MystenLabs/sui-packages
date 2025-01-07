module 0x8035dac284d3a6206bc1ab285bb8b9d6d1625fecf666826dffbefd8c8791543e::snk {
    struct SNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNK>(arg0, 9, b"SNK", b"BabySnake", b"$This token was created for transactions and finance#", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b608221-2027-4a5b-a708-6ae2fc076cd9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

