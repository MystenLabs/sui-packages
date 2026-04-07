module 0xf432f3bb2e88ffffe67ab9adf1f3f220710e090f95f7a4775a1d4bd67cd34036::base_4a8 {
    struct BASE_4A8 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<BASE_4A8>, arg1: 0x2::coin::Coin<BASE_4A8>) {
        0x2::coin::burn<BASE_4A8>(arg0, arg1);
    }

    fun init(arg0: BASE_4A8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASE_4A8>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-cZXFicwLkW.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<BASE_4A8>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BASE_4A8>>(v1);
    }

    public fun make(arg0: &mut 0x2::coin::TreasuryCap<BASE_4A8>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BASE_4A8> {
        0x2::coin::mint<BASE_4A8>(arg0, arg1, arg2)
    }

    public entry fun make_to(arg0: &mut 0x2::coin::TreasuryCap<BASE_4A8>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BASE_4A8>>(0x2::coin::mint<BASE_4A8>(arg0, arg1, arg3), arg2);
    }

    public fun module_hash() : u64 {
        4660
    }

    // decompiled from Move bytecode v6
}

