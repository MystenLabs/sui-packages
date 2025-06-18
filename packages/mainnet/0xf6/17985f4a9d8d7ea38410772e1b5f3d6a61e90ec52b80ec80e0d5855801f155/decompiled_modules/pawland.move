module 0xf617985f4a9d8d7ea38410772e1b5f3d6a61e90ec52b80ec80e0d5855801f155::pawland {
    struct PAWLAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWLAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWLAND>(arg0, 9, b"PAWLAND", b"PAWTATO", b"Hold to mint NFT free", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/bdca851ba072bcd4f4247f0b91090f02blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWLAND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWLAND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

