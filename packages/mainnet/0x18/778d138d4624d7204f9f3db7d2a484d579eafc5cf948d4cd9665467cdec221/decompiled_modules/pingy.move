module 0x18778d138d4624d7204f9f3db7d2a484d579eafc5cf948d4cd9665467cdec221::pingy {
    struct PINGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINGY>(arg0, 6, b"PINGY", b"Pingy Fun", x"57656c636f6d6520746f207468652066726f737479207965742073757270726973696e676c792068656172747761726d696e6720776f726c64206f662050494e47592c207768657265206f75722061737069726174696f6e7320736f61720a61732068696768206173206f757220666c6170732063616e2074616b65207573737472616967687420746f20746865206d6f6f6e2c206f72206174206c6561737420612066657720696e63686573206f6666207468652067726f756e642c6275742077686f73206d6561737572696e673f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_18f3247687.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

