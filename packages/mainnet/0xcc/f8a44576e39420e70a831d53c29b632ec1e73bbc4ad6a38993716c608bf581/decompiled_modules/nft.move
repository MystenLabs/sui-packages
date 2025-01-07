module 0xccf8a44576e39420e70a831d53c29b632ec1e73bbc4ad6a38993716c608bf581::nft {
    struct WhalemeNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WhalemeNFT{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"Whaleme"),
            url  : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmfD3KnEbyjREGzHo7XKPcUpRd6eUyVZimvYnPNCqHGTua"),
        };
        0x2::transfer::transfer<WhalemeNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

