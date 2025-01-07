module 0x7076e861c1ea027ef8c68bc4a24920d8dfd10ff3eea73ece0a2cd98b3bbf97d5::pearl {
    struct PEARL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEARL>(arg0, 6, b"PEARL", b"Pearlie The Clam", b"Our mission is to create a vibrant community around Pearlie the Clam. We aim to reach the stars starting from the bottom of the sea!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731119409685.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEARL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEARL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

