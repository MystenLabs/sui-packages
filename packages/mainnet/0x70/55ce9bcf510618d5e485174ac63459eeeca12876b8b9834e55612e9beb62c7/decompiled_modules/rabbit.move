module 0x7055ce9bcf510618d5e485174ac63459eeeca12876b8b9834e55612e9beb62c7::rabbit {
    struct RABBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RABBIT>(arg0, 9, b"RABBIT", b"Rock", b"Native meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1b3e9a30-ae1c-4b4b-82d0-02543549ece5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RABBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RABBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

