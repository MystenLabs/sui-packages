module 0x8e6116698ea03c4de824906eee80d8e8543972cdc54e7c1331f9ffcff6a2e65b::bos {
    struct BOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOS>(arg0, 9, b"BOS", b"BUTTCOIN ON SUI", b"First Buttcoin on $SUI Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/45b1833f8cfb20180ecc70af5c165af7blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

