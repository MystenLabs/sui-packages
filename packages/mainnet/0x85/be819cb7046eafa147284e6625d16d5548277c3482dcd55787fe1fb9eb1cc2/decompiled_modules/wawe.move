module 0x85be819cb7046eafa147284e6625d16d5548277c3482dcd55787fe1fb9eb1cc2::wawe {
    struct WAWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWE>(arg0, 9, b"WAWE", b"Wawe og", b"Real wawe og", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc952d1b-7a1a-4fd4-9128-d8381d59c65b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

