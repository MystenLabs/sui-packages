module 0x1e5191ea295472da6935cae745740f3f3c60360a4d5b83104c61ee6178d86c74::quokkaroi {
    struct QUOKKAROI has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUOKKAROI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUOKKAROI>(arg0, 9, b"QUOKKAROI", b"QuokkaROI", b"The happiest token on chain! QuokkaROI's infectious grin spreads good vibes and positive returns wherever it goes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreidcpg7ymscefyeh6qd5q7lwktkdzfyxgrmnvcg4vvbkirajezyeqe")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<QUOKKAROI>(&mut v2, 1000000000000000000, @0x86d23a68cdddbdb748c8d40aa226afed8e5f87c5d5dc8e904c13971759339c73, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUOKKAROI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUOKKAROI>>(v1);
    }

    // decompiled from Move bytecode v6
}

