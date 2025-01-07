module 0xef6382a17ae03c27f47b21567562a23800bfd3c51dda159353ddbc8a9be71830::svg_nft {
    struct SvgNft has store, key {
        id: 0x2::object::UID,
        seed: 0x1::string::String,
        r: u8,
        g: u8,
        b: u8,
        sr: u8,
        sg: u8,
        sb: u8,
        x1: u8,
        y1: u8,
        x2: u8,
        y2: u8,
        x3: u8,
        y3: u8,
        x4: u8,
        y4: u8,
        x5: u8,
        y5: u8,
        x6: u8,
        y6: u8,
    }

    struct SVG_NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVG_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Simple SVG NFT {seed}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Generated and stored on-chain"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"data:image/svg+xml,<svg viewBox=\"0 0 255 255\" width=\"255\" height=\"255\" xmlns=\"http://www.w3.org/2000/svg\"><path style=\"fill: rgb({r}, {g}, {b}); stroke: rgb({sr}, {sg}, {sb});\" d=\"M {x1} {y1} L {x2} {y2} L {x3} {y3} L {x4} {y4} L {x5} {y5} L {x6} {y6} L {x1} {y1} Z\"/></svg>"));
        let v4 = 0x2::package::claim<SVG_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SvgNft>(&v4, v0, v2, arg1);
        0x2::display::update_version<SvgNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SvgNft>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::address::to_bytes(0x2::tx_context::fresh_object_address(arg0));
        let v1 = &v0;
        let v2 = SvgNft{
            id   : 0x2::object::new(arg0),
            seed : 0x1::string::utf8(0x2::hex::encode(*v1)),
            r    : *0x1::vector::borrow<u8>(v1, 0),
            g    : *0x1::vector::borrow<u8>(v1, 1),
            b    : *0x1::vector::borrow<u8>(v1, 2),
            sr   : *0x1::vector::borrow<u8>(v1, 3),
            sg   : *0x1::vector::borrow<u8>(v1, 4),
            sb   : *0x1::vector::borrow<u8>(v1, 5),
            x1   : *0x1::vector::borrow<u8>(v1, 6),
            y1   : *0x1::vector::borrow<u8>(v1, 7),
            x2   : *0x1::vector::borrow<u8>(v1, 8),
            y2   : *0x1::vector::borrow<u8>(v1, 9),
            x3   : *0x1::vector::borrow<u8>(v1, 10),
            y3   : *0x1::vector::borrow<u8>(v1, 11),
            x4   : *0x1::vector::borrow<u8>(v1, 12),
            y4   : *0x1::vector::borrow<u8>(v1, 13),
            x5   : *0x1::vector::borrow<u8>(v1, 14),
            y5   : *0x1::vector::borrow<u8>(v1, 15),
            x6   : *0x1::vector::borrow<u8>(v1, 16),
            y6   : *0x1::vector::borrow<u8>(v1, 17),
        };
        0x2::transfer::transfer<SvgNft>(v2, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

