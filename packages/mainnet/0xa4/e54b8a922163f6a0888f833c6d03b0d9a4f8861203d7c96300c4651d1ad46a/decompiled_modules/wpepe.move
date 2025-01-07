module 0xa4e54b8a922163f6a0888f833c6d03b0d9a4f8861203d7c96300c4651d1ad46a::wpepe {
    struct WPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WPEPE>(arg0, 6, b"WPEPE", b"Wiz Pepe", b"ABRA KADABRA RAHA everywhere. Bling gold cash bag platinum and uranium. Wizard of PEPE kadabra your wallet. Trillion dollar Bitcoin, your house rich. SHALAKA.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000019310_9d75135035.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

