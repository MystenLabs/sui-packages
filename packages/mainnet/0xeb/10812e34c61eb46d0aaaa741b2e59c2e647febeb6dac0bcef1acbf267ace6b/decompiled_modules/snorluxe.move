module 0xeb10812e34c61eb46d0aaaa741b2e59c2e647febeb6dac0bcef1acbf267ace6b::snorluxe {
    struct SNORLUXE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNORLUXE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNORLUXE>(arg0, 9, b"SNORLUX", b"SnorLuxe", x"466f722074686f73652077686f206d6f6f6e207768696c65207468657920736e6f6f7a652e20536e6f724c7578652069732074686520756c74696d617465206c6169642d6261636b20746f6b656ee280946a757374207374616b6520616e64206e61702e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid3lvqnndfu3l6tv3p67n6dpmedvyxlqrrysxuowfxu6qkndckc6a")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNORLUXE>(&mut v2, 1000000000000000000, @0x86d23a68cdddbdb748c8d40aa226afed8e5f87c5d5dc8e904c13971759339c73, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNORLUXE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNORLUXE>>(v1);
    }

    // decompiled from Move bytecode v6
}

