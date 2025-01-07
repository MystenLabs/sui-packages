module 0x4e98a296a71b6df9da428770579dc75706befe82d7ef5273b435406b1faedc45::milk {
    struct MILK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILK>(arg0, 9, b"MILK", b"DAIRY MILK", b"Milk for healthy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3960029f-d998-41ea-aa95-6191063ca3f0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MILK>>(v1);
    }

    // decompiled from Move bytecode v6
}

