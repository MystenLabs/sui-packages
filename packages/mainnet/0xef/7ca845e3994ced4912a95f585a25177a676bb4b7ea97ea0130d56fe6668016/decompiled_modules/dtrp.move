module 0xef7ca845e3994ced4912a95f585a25177a676bb4b7ea97ea0130d56fe6668016::dtrp {
    struct DTRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTRP>(arg0, 6, b"DTRP", b"Donuts Trump", b"Donuts Trump The King Of Crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_6_9df8b281b4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DTRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

