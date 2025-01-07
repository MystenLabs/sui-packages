module 0x709bb2d5246db4195ed89e627bec69700f54f42172fa0d978c22559579e37778::dkfjfkfk {
    struct DKFJFKFK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKFJFKFK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKFJFKFK>(arg0, 9, b"DKFJFKFK", b"Irrkkr", b"Djdkdkdk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c9e4908-302a-4b93-ba48-ecc04e49d229.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKFJFKFK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DKFJFKFK>>(v1);
    }

    // decompiled from Move bytecode v6
}

