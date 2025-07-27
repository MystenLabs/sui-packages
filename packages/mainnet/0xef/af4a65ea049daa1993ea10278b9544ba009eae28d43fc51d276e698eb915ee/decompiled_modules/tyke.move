module 0xefaf4a65ea049daa1993ea10278b9544ba009eae28d43fc51d276e698eb915ee::tyke {
    struct TYKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYKE>(arg0, 6, b"TYKE", b"Tyke The Dog", x"54796b65205468652053756920416c70686120446f670a54594b452069736e74206a75737420616e7920444f4720686520697320746865206c6976696e672e20576f6f66207061726f6479206f6620736f6d657468696e672077617920746f6f20736572696f75732e205768696c65206f74686572732061726775652061626f75742063686172747320616e6420636f696e732e2054594b45204a756d70206f6e206b6579626f6172647320616e64206163636964656e74616c6c79206275797320736e61636b73207769746820736f6d656f6e65732063726564697420636172642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiebidiurrilox6oiyg5it3wcftrljzg7vubjzpohmka5rpn6uqqa4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TYKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

