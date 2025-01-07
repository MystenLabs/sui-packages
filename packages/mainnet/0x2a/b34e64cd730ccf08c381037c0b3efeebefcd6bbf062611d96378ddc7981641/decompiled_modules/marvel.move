module 0x2ab34e64cd730ccf08c381037c0b3efeebefcd6bbf062611d96378ddc7981641::marvel {
    struct MARVEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARVEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARVEL>(arg0, 9, b"MARVEL", b"Deadpool", b"Marvel Jesus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e048c43a-eb83-42f0-acb4-dc86892ab3ce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARVEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARVEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

