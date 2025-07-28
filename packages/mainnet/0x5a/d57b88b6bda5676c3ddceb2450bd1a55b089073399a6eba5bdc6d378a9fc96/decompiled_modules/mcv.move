module 0x5ad57b88b6bda5676c3ddceb2450bd1a55b089073399a6eba5bdc6d378a9fc96::mcv {
    struct MCV has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCV>(arg0, 6, b"MCV", b"Mill City III", b"Mill City Ventures III has announced a $450 million private placement to launch a corporate Sui treasury strategy. The round is led by London-based hedge fund Karatage, with a matching investment from the Sui Foundation. Other participants include Big Brain Holdings, Galaxy Digital, Pantera Capital, Electric Capital, and ParaFi Capital.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicefuzvq7ms22rfmj7dxp4cyh2nobsbb5kt2mxes7oxnmfxicviga")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MCV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

