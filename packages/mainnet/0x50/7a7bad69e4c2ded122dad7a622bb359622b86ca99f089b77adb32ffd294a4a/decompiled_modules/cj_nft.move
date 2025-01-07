module 0x507a7bad69e4c2ded122dad7a622bb359622b86ca99f089b77adb32ffd294a4a::cj_nft {
    struct CJNFT has copy, drop {
        creator: address,
    }

    struct CJNFTMinted has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x1::string::String,
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CJNFTMinted{
            id   : 0x2::object::new(arg2),
            name : arg0,
            url  : arg1,
        };
        0x2::transfer::public_transfer<CJNFTMinted>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun transfer_nft(arg0: CJNFTMinted, arg1: address) {
        0x2::transfer::public_transfer<CJNFTMinted>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

