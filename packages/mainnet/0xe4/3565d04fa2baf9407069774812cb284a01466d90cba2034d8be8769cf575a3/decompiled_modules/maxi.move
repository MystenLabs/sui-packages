module 0xe43565d04fa2baf9407069774812cb284a01466d90cba2034d8be8769cf575a3::maxi {
    struct MAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAXI>(arg0, 9, b"MAXI", b"Maxi", x"484f444c20666f72206c6f6e67202c206265636f6d6520612024535549204d6178692e0a54617020696e746f20746865206c6f7265206f662074686520776174657220636861696e2e0a4e6f2046554420686572652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAXI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAXI>>(v2, @0x7ed87e6f0627cc9a41b5aaf638660f4ca6b68fc3b7c2dee5a6657d7288dd1a1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

