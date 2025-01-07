module 0xb1b66733aeda60bfb1e09328908e110681c77c55f062946b3ebed717eaa59680::puffer {
    struct PUFFER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFER>(arg0, 6, b"PUFFER", b"Puffer Pete", x"507566666572506574652074686520426c6f776669736820696e666c6174657320796f75722077616c6c6574207769746820657665727920706f70206f6620746865206d61726b657420627562626c65206974277320616c6c207370696b65732068657265210a4a6f696e206265666f72652077652068697420446578", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_1_376240395f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFER>>(v1);
    }

    // decompiled from Move bytecode v6
}

