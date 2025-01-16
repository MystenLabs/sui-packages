module 0xd1aea83a18c207d75564358fe5b21af5192ac84966bdb53b55efa9dfaba7968::lamthu {
    struct LAMTHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMTHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMTHU>(arg0, 9, b"LAMTHU", b"b3_tr4i", b"Tao cho co", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/62ea25eb-a024-40a7-87fa-d56069f25a33.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMTHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAMTHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

