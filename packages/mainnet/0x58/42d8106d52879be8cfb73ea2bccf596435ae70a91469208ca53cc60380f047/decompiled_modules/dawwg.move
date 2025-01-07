module 0x5842d8106d52879be8cfb73ea2bccf596435ae70a91469208ca53cc60380f047::dawwg {
    struct DAWWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAWWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAWWG>(arg0, 6, b"DawwG", b"suiDawg", b"Just your average Shitcoin ToKer using AIMUM? and blockchain strains to create random crop/Drops to grow? like nfts' this could be nothing @just like your Dawgy wallet?  < trust me bro its nothing yet. tolerance  will be tested if you buy now go easy cuple tokes a night.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/stardawg_8403353c89.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAWWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAWWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

