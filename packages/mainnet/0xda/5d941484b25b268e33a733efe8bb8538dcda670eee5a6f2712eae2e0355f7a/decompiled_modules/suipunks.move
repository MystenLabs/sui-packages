module 0xda5d941484b25b268e33a733efe8bb8538dcda670eee5a6f2712eae2e0355f7a::suipunks {
    struct SUIPUNKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUNKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUNKS>(arg0, 6, b"SUIPUNKS", b"PUNKS SUI", b"The NFT Collection That Proves You Are One Of The Ogs In The Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_023819317_dbaa8493bf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUNKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUNKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

