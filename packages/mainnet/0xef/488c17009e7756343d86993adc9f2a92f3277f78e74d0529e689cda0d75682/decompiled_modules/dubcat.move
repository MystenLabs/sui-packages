module 0xef488c17009e7756343d86993adc9f2a92f3277f78e74d0529e689cda0d75682::dubcat {
    struct DUBCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUBCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUBCAT>(arg0, 6, b"DUBCAT", b"Dubcat", b"$DUBCAT- The Cat that drops beats on the blockchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dubcatt_9953880597.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUBCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUBCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

