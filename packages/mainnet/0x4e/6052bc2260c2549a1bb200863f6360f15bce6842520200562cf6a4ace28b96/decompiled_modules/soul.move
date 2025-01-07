module 0x4e6052bc2260c2549a1bb200863f6360f15bce6842520200562cf6a4ace28b96::soul {
    struct SOUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOUL>(arg0, 9, b"SOUL", b"SOUL MAGIC", b"New token of decentraland community, world of magic.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1fbb4ce2-9068-464c-b6ec-ae85669401ea-1000014106.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

